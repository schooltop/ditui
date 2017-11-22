class CustomersVendor < ApplicationRecord
	has_many :customers
	has_many :vendors
	#belongs_to :gps_location
end
