class User < ApplicationRecord
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

    has_many :customers  

    def vendors
      self.customers&.map{|cu|cu.vendors}.flatten.uniq
    end   

    def customers_vendors
      self.customers&.map{|cu|cu.customers_vendors}.flatten.uniq
    end

    def gps
      self.customers&.map{|cu|cu.gps_locations}.flatten.uniq
    end 

    def gps_size
      self.customers&.map{|cu|cu.gps_locations}.flatten.uniq.size
    end   

    def visit_customers
      self.customers&.map{|cu|cu.customers}.flatten.uniq
    end  

    def my_from
      self.customers&.map{|cu|CustomerVisit.my_from(cu)}.flatten.uniq
    end

   def my_to
      self.customers&.map{|cu|CustomerVisit.my_to(cu)}.flatten.uniq
   end 
	
end