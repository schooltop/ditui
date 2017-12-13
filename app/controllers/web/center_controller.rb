class Web::CenterController < Web::BaseController
	layout "center"

	def index
    
	end

	def my_vendor
		@customers_vendors = current_user.customers_vendors
		@customers_vendors = @customers_vendors.select{|_|_.vendor.name == params[:name] } if params[:name].present?
		@customers_vendors = @customers_vendors.select{|_|_.vendor.created_at >= params[:time] } if params[:time].present? 
	end

	def my_visit
        @my_from = current_user.my_from
		@my_from = @my_from.select{|_|_.name == params[:name] } if params[:name].present?
		@my_from = @my_from.select{|_|_.created_at >= params[:time] } if params[:time].present? 
	end

	def visits_converse_create
      @visits_converse = VisitsConverse.new(visits_converse_params)
      @visits_converse.save
      @to_id = visits_converse_params[:to_id].to_i
      @converses = VisitsConverse.where(" (from_id = #{current_user.id} and to_id = #{@to_id} ) or (to_id = #{current_user.id} and from_id = #{@to_id} ) ")
      redirect_to :action=>"my_visit"
    end

	def my_search
        @my_search = current_user.gps
		@my_search = @my_search.select{|_|_.customer.name == params[:name] } if params[:name].present?
		@my_search = @my_search.select{|_|_.created_at >= params[:time] } if params[:time].present? 
	end

	private

	def visits_converse_params
      params.require(:visits_converse).permit(:from_id,:to_id,:converse)
    end

end