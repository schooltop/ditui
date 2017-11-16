class VendorsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_vendor, only: [:show, :edit, :update, :destroy,:add_comments]
  layout "web"

  # GET /vendors
  # GET /vendors.json
  def index
    @vendors = Vendor.all.page(params[:page]).per(10)
  end

  def top_search
    @vendors = Vendor.where("title like '#{params[:title]}%' ").page(params[:page]).per(9)
    render "index"
  end

  def add_comments
    Comment.create(vendor_id:@vendor.id,content:params[:comment_text])
    render :partial => 'add_comments'
  end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    @vendor.update(view_count: @vendor.view_count.to_i + 1)


    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      cv = CustomersVendor.find_or_create_by(customer_id:params[:customer_id],vendor_id:@vendor.id,gps_location_id:params[:gps_id])
      cv.update(view_count:cv.view_count.to_i + 1) 
    end
  end

  # 显示gps信息
  def show_gps
    require 'exifr/jpeg'
    @image = Attachment.find(params[:id])
    path = "#{Rails.root}/public#{@image.path.to_s}"
    exif = EXIFR::JPEG.new(path)
    @latitude = exif.gps&.latitude||39.9717219722
    @longitude = exif.gps&.longitude||116.4911780001
    redirect_to "http://www.gpsspg.com/maps.htm?maps=3&s=#{@latitude},#{@longitude}"
  end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
  end

  # GET /vendors/1/edit
  def edit
  end

  # POST /vendors
  # POST /vendors.json
  def create
    @vendor = Vendor.new(vendor_params)
    respond_to do |format|
      if @vendor.save
        unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "vendor",attachment_entity_id: @vendor.id , path: params[:draft_img], created_by: 1 ) 
          @vendor.cover_img = attachment.id
          @vendor.save
        end
        format.html { redirect_to @vendor, notice: 'vendor was successfully created.' }
        format.json { render :show, status: :created, location: @vendor }
      else
        format.html { render :new }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendors/1
  # PATCH/PUT /vendors/1.json
  def update
    respond_to do |format|
      if @vendor.update(vendor_params)
        unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "vendor",attachment_entity_id: @vendor.id , path: params[:draft_img], created_by: 1 ) 
          @vendor.cover_img = attachment.id
          @vendor.save
        end
        format.html { redirect_to @vendor, notice: 'vendor was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor }
      else
        format.html { render :edit }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
    @vendor.destroy
    respond_to do |format|
      format.html { redirect_to vendors_url, notice: 'vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_image
    attachment = Attachment.create(attachment_entity_type: "vendor", path: params[:wang_editor_file], created_by: 1 )
    render plain: attachment.path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit(:category_id,:title,:name,:content,:cover_img)
    end
end
