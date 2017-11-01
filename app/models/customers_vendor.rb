class CustomersVendor < ApplicationRecord
	has_many :customers
	has_many :vendors
end
