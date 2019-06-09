class Admin::StoresController < Admin::BaseController
  require 'exifr/jpeg'

	  def index
   	 @q = SearchParams.new(params[:search_params] || {})
   	 @stores = Store.default_where(@q.attributes(self)).page(params[:page]).per(10)
  	end

  	def new
   	  @store = Store.new
    end

    def edit
     @html_title = "Edit store"
     @store =  Store.find(params[:id])
     render :layout => false
    end

    def show
      @html_title =  "Show store"
      @store =  Store.find(params[:id])
      render :layout => false
    end


    def create
      @store = Store.new(store_params)
      @store.save
      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Store",attachment_entity_id: @store.id , path: params[:draft_img], created_by: 1 ) 
          @store.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @store.latitude = @latitude
          @store.longitude = @longitude
          @store.save
      end
    end

    def update
      @store = Store.find(params[:id])
      @store.update(store_params)

      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Store",attachment_entity_id: @store.id , path: params[:draft_img], created_by: 1 ) 
          @store.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @store.latitude = @latitude
          @store.longitude = @longitude
          @store.save
      end
    end

    def upload_image
      attachment = Attachment.create(attachment_entity_type: "Store", path: params[:wang_editor_file], created_by: 1 )
      render plain: attachment.path
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit!
    end

end