class Admin::CommunitiesController < Admin::BaseController
  require 'exifr/jpeg'

	  def index
   	 @q = SearchParams.new(params[:search_params] || {})
   	 @communities = Community.default_where(@q.attributes(self)).page(params[:page]).per(10)
  	end

  	def new
   	  @community = Community.new
    end

    def edit
     @html_title = "Edit community"
     @community =  Community.find(params[:id])
     render :layout => false
    end

    def show
      @html_title =  "Show community"
      @community =  Community.find(params[:id])
      render :layout => false
    end


    def create
      @community = Community.new(community_params)
      @community.save
      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Community",attachment_entity_id: @community.id , path: params[:draft_img], created_by: 1 ) 
          @community.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @community.latitude = @latitude
          @community.longitude = @longitude
          @community.save
      end
    end

    def update
      @community = Community.find(params[:id])
      @community.update(community_params)

      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Community",attachment_entity_id: @community.id , path: params[:draft_img], created_by: 1 ) 
          @community.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @community.latitude = @latitude
          @community.longitude = @longitude
          @community.save
      end
    end

    def upload_image
      attachment = Attachment.create(attachment_entity_type: "Community", path: params[:wang_editor_file], created_by: 1 )
      render plain: attachment.path
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_params
      params.require(:community).permit!
    end

end