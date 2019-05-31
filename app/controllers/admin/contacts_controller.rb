class Admin::ContactsController < Admin::BaseController

  before_action :set_contact, only: [:edit, :update, :destroy, :add_account]

  def index
    @vendor = Vendor.find params[:vendor_id]
    @contacts = @vendor.contacts.certified.actived.order(:name)
  end

  def new
    @contact = Contact.new
  end

  def create
    Contact.create(contact_params.merge(vendor_id: params[:vendor_id], certification: :certified))
    redirect_to action: :index, vendor_id: params[:vendor_id]
  end

  def edit
  end

  def update
    @contact.update(contact_params)
  end

  def destroy
    @contact.update(active: :deleted)
  end

  def add_account
    if @contact.mobile.blank?
      flash[:msg] = 'Failed, Mobile is empty.'
      redirect_to action: :index, vendor_id: @contact.vendor_id and return
    end
    user = User.new(name: @contact.name, email: @contact.email, mobile: @contact.mobile, password: '111111')
    if user.valid?
      user.save
      @contact.update(user_id: user.id)
      AccountMailer.add_account(@contact.id).deliver_later
      flash[:notice] = 'Success.'
      redirect_to admin_contacts_url(vendor_id: @contact.vendor_id)
    else
      if user.errors.messages[:email].present?
        flash[:msg] = 'Failed, Email had been taken.'
      elsif user.errors.messages[:mobile].present?
        flash[:msg] = 'Failed, Mobile had been taken.'
      else
        flash[:msg] = 'Failed.'
      end
      redirect_to action: :index, vendor_id: @contact.vendor_id
    end
  end

  private

  def set_contact
    @contact = Contact.find params[:id]
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :gender, :email, :mobile, :tel, :title, :buyer, :vendor, :country)
  end

end
