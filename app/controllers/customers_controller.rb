class CustomersController < ApplicationController
  before_action :authenticate_user!, except: [:logout,:new,:create,:index,:detail]
  before_action :set_customer, only: [:index,:show, :edit, :update, :destroy,:add_comments]
  layout "web"
  require 'exifr/jpeg'

  # GET /vendors
  # GET /vendors.json
  def index
    @customers = Customer.like_customer(params[:latitude],params[:longitude])
    @vendors = Vendor.like_vendor(params[:latitude],params[:longitude])
    @gps = GpsLocation.find(params[:gps_id].to_i)
  end
 
  # gps明细表
  def detail
   if !params[:market_id].present?
     render :layout=>false 
   elsif params[:market_id].include?("markets")
     @market = Market.find(params[:market_id].split("_").last)
     render :layout=>false 
   else
     @vendor = Vendor.find(params[:market_id].split("_").last) 
     redirect_to "/vendors/#{@vendor.id}"
   end
  end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    if params[:from_id]
      cv = CustomerVisit.find_or_create_by(from_id:params[:from_id],to_id:params[:to_id])
      cv.update(view_count:cv.view_count.to_i + 1) 
    end 
  end

  # GET /vendors/new
  def new
    @customer = Customer.new(name:cookies[:opxPID])
  end

  # GET /vendors/1/edit
  def edit
  end

  # POST /vendors
  # POST /vendors.json
  def create
    @customer = Customer.find_or_create_by(name:cookies[:opxPID])
    if current_user.present?
      @customer.user_id = current_user.id 
      @customer.save!
    end
    unless params[:draft_img].blank?
      attachment = Attachment.create(attachment_entity_type: "Customer",attachment_entity_id: @customer.id , path: params[:draft_img], created_by: 1 ) 
      path = "#{Rails.root}/public#{attachment.path.to_s}"
      exif = EXIFR::JPEG.new(path)
      @latitude = exif.gps&.latitude||39.9717219722
      @longitude = exif.gps&.longitude||116.4911780001
      gps = GpsLocation.create(customer_id:@customer.id,latitude:@latitude,longitude:@longitude,cover_img:attachment.id)
    end
    redirect_to :action=>"index",latitude:@latitude,longitude:@longitude,id:@customer.id,gps_id:gps.id
  end

  # PATCH/PUT /vendors/1
  # PATCH/PUT /vendors/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Customer",attachment_entity_id: @customer.id , path: params[:draft_img], created_by: 1 ) 
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          GpsLocation.create(customer_id:@customer.id,latitude:@latitude,longitude:@longitude,cover_img:attachment.id)
        end
        format.html { redirect_to @customer, notice: 'vendor was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_image
    attachment = Attachment.create(attachment_entity_type: "Customer", path: params[:wang_editor_file], created_by: 1 )
    render plain: attachment.path
  end

  # DELETE /resource/sign_out
  def logout
    sign_out
    redirect_to vendors_path
    #super
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = params[:id].present? ? Customer.find(params[:id]) : Customer.find_or_create_by(name:cookies[:opxPID])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:category_id,:name,:content)
    end
end
