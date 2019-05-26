class Admin::MarketsController < Admin::BaseController

	  def index
   	 @q = SearchParams.new(params[:search_params] || {})
   	 @markets = Market.default_where(@q.attributes(self)).page(params[:page]).per(10)
  	end

  	def new
   	  @market = Market.new
    end

    def edit
     @html_title = "Edit market"
     @market =  Market.find(params[:id])
     render :layout => false
    end

    def show
      @html_title =  "Show market"
      @market =  Market.find(params[:id])
      render :layout => false
    end


    def create
      @market = Market.new(market_params)
      @market.save
      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Market",attachment_entity_id: @market.id , path: params[:draft_img], created_by: 1 ) 
          @market.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @market.latitude = @latitude
          @market.longitude = @longitude
          @market.save
      end
    end

    def update
      @market = Market.find(params[:id])
      @market.update(market_params)

      unless params[:draft_img].blank?
          attachment = Attachment.create(attachment_entity_type: "Market",attachment_entity_id: @market.id , path: params[:draft_img], created_by: 1 ) 
          @market.cover_img = attachment.id
          path = "#{Rails.root}/public#{attachment.path.to_s}"
          exif = EXIFR::JPEG.new(path)
          @latitude = exif.gps&.latitude||39.9717219722
          @longitude = exif.gps&.longitude||116.4911780001
          @market.latitude = @latitude
          @market.longitude = @longitude
          @market.save
      end
    end

    def upload_image
      attachment = Attachment.create(attachment_entity_type: "Market", path: params[:wang_editor_file], created_by: 1 )
      render plain: attachment.path
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_market
      @market = Market.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_params
      params.require(:market).permit!
    end

end