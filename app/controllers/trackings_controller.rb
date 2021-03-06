class TrackingsController < ApplicationController
  # js请求  
  def index
    tracking_hash = {}
    # 本机作为第三方的cookie
    tracking_hash[:opxPID] = cookies[:opxPID]
    # 宿主网站cookie
    tracking_hash[:time_now] = Time.now.strftime("%Y-%m-%d %H-%M-%S")
    tracking_hash[:domain] = request.raw_host_with_port
    tracking_hash[:opxtitle] = params[:opxtitle] 
    tracking_hash[:opxreferrer] = CGI.unescape(params[:opxreferrer]) 
    tracking_hash[:opxurl] = CGI.unescape(params[:opxurl])  
    tracking_hash[:opxid] = params[:opxid] 
    tracking_hash[:ip] = (request.env['HTTP_X_FORWARDED_FOR'].present? ? request.env['HTTP_X_FORWARDED_FOR'] : request.remote_ip).split(",").first
    tracking_hash[:opxuserAgent] = CGI.unescape(params[:opxuserAgent]) 

    # 统计游客url浏览记录
    cache_array("#{cookies[:opxPID]}_url_list","#{tracking_hash[:time_now]}@#{params[:opxurl]}")
    cache_sum("#{cookies[:opxPID]}_uuids")
    
    unless cache_read("uuids_list") && (cache_read("uuids_list").include? cookies[:opxPID])
      # uuids数统计加1
      cache_sum("uuids")
      # 首次登录信息
      cache_value("#{cookies[:opxPID]}_message",tracking_hash)
    end

    # uuid添加进数组
    cache_array("uuids_list",cookies[:opxPID],"uniq")

    # 当前用户关联
    opxid = Customer.find_by(name:cookies[:opxPID])
    cache_value(cookies[:opxPID],opxid.id.to_i) 

    # 根据url来触发响应
    # 根据
    TRACKING_TAG.keys.each do |_|
      if params[:opxurl].include? _.to_s
        cache_sum(_)
        cache_array("#{_}_uuids",cookies[:opxPID],"uniq") 
        cache_array("#{cookies[:opxPID]}_tags",_,"uniq")
        cache_sum("#{cookies[:opxPID]}_#{_}")
      end
    end
    
    return render :js => ""
  end
end

