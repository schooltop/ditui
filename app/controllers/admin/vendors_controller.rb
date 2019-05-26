class Admin::VendorsController < Admin::BaseController

	  def index
   	 @q = SearchParams.new(params[:search_params] || {})
   	 @vendors = Vendor.default_where(@q.attributes(self)).page(params[:page]).per(10)
  	end

  	def new
   	  @vendor = Vendor.new
    end

    def edit
     @html_title = "Edit Vendor"
     @vendor =  Vendor.find(params[:id])
     render :layout => false
    end

    def show
      @html_title =  "Show Vendor"
      @vendor =  Vendor.find(params[:id])
      render :layout => false
    end

    def create
      @vendor = Vendor.new(vendor_params)
      @vendor.save
      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Vendor",attachment_entity_id: @vendor.id , path: params[:draft_img], created_by: 1 ) 
          @vendor.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @vendor.latitude = @latitude
          @vendor.longitude = @longitude
          @vendor.save
      end
    end

    def update
      @vendor = Vendor.find(params[:id])
      @vendor.update(vendor_params)

      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Vendor",attachment_entity_id: @vendor.id , path: params[:draft_img], created_by: 1 ) 
          @vendor.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @vendor.latitude = @latitude
          @vendor.longitude = @longitude
          @vendor.save
      end
    end

    def upload_image
      attachment = Attachment.create(attachment_entity_type: "Vendor", path: params[:wang_editor_file], created_by: 1 )
      render plain: attachment.path
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit!
    end

end