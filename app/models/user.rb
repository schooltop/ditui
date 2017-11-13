class User < ApplicationRecord
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

    has_many :customers  

    def vendors
      self&.customers&.map{|cu|cu.vendors}.flatten.uniq
    end   
	
end