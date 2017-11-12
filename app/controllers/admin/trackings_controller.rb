class Admin::TrackingsController < Admin::BaseController

  def index
    p cache_read("uuids_list")
    @uuids = cache_read("uuids_list")||[]
    p "11"*100
    p @uuids
  end
  	
  def analysis
    @employee = User.find(params[:em_id].to_i) if params[:em_id].to_i > 0
    @opxpid = params[:opxpid]
    @message = cache_read("#{@opxpid}_message")||{}
    @urls = cache_read("#{@opxpid}_url_list").reverse||[]
    valid_keys = cache_read("#{@opxpid}_tags")
    @tags = TRACKING_TAG.slice(*valid_keys).values.to_s
  end	 

  # 清除所有缓存
  def delete_tracking
    TrackingRecord.load_tracking
  end

  # 热度分析
  def hot_analysis
    @hot = params[:hot_tag]
    @hot_tag = TRACKING_TAG[params[:hot_tag]]
    @uuids = cache_read("#{@hot}_uuids")||[]
  end

end
