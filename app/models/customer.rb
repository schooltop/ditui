class Customer < ApplicationRecord
	has_many :gps_locations
  belongs_to :user
  has_many :customers_vendors
	has_and_belongs_to_many :vendors, join_table: :customers_vendors

	def self.like_customer(latitude,longitude)
      GpsLocation.find_by_sql("select *, abs(latitude-#{latitude}) as min_latitude , abs(longitude-#{longitude}) as min_longitude  
  		from gps_locations
  		order by min_latitude, min_longitude, created_at 
  		limit 10 ")&.map{|_|_.customer}.uniq
	end

	def self.view_count_top
      CustomersVendor.find_by_sql("select customers.id,customers.name,count(customers_vendors.customer_id) as count_customer_ids from customers_vendors 
       	left join customers 
      	on customers.id = customers_vendors.customer_id
      	group by customers_vendors.customer_id
      	order by count_customer_ids desc
      	limit 5
      	")
  end

end
