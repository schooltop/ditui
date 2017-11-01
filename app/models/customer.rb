class Customer < ApplicationRecord
	has_many :gps_locations
	has_and_belongs_to_many :vendors, join_table: :customers_vendors

	def self.like_customer(latitude,longitude)
      GpsLocation.find_by_sql("select *, abs(latitude-#{latitude}) as min_latitude , abs(longitude-#{longitude}) as min_longitude  
  		from gps_locations
  		order by min_latitude, min_longitude, created_at 
  		limit 10 ")&.map{|_|_.customer}.uniq
	end

end
