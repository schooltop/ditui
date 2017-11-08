class Web::BaseController < ActionController::Base
    protect_from_forgery with: :exception
    layout "web"
    before_action :authenticate_user!
end
