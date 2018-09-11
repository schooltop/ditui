class Web::BaseController < ActionController::Base
    protect_from_forgery with: :exception
    layout "web"
    before_action :authenticate_user!
    before_action :update_or_create_opxpid

    def update_or_create_opxpid
	    unless cookies[:opxPID]
	      t_format = Time.now.strftime('%Y%m%d%H%M%S%6N')
	      randid = "%08d" % (rand*100000000).to_i
	      opxpid = "#{t_format}#{randid}"
	      cookies[:opxPID] = opxpid
	    end
	end

end
