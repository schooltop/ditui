class Web::CenterController < Web::BaseController
	layout "center"

	def index
    
	end

	def my_vendor
		@customers_vendors = current_user.customers_vendors
		@customers_vendors = @customers_vendors.select{|_|_.vendor.name == params[:name] } if params[:name].present?
		@customers_vendors = @customers_vendors.select{|_|_.vendor.created_at >= params[:time] } if params[:time].present? 
	end

	def my_visite

	end

	def my_search

	end

end