class CustomersVendor < ApplicationRecord
	has_many :customers
	has_many :vendors
	# 我访问的供应商记录
	#belongs_to :gps_location
end
