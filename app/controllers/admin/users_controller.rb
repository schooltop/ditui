class Admin::UsersController < Admin::BaseController

	def index
   	 @q = SearchParams.new(params[:search_params] || {})
   	 @users = User.default_where(@q.attributes(self)).page(params[:page]).per(10)
  	end

  	def new
   	  @user = User.new
    end

    def edit
     @html_title = "Edit user"
     @user =  User.find(params[:id])
     render :layout => false
    end

    def show
      @html_title =  "Show user"
      @user =  User.find(params[:id])
      render :layout => false
    end


    def create
      @user = User.new(user_params)
      @user.save
    end

    def update
      @user = User.find(params[:id])
      @user.update(user_params)
    end

    def show_name
      @user = User.find(params[:id])
      render json: {name: @user.name}
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:password,:email)
    end

end