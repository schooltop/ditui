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

	def my_search
        @my_search = current_user.gps
		@my_search = @my_search.select{|_|_.customer.name == params[:name] } if params[:name].present?
		@my_search = @my_search.select{|_|_.created_at >= params[:time] } if params[:time].present? 
	end

end