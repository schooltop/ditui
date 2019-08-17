class CustomerVisit < ApplicationRecord
   
   # 我的访问
   def self.my_from(customer_id)
     to_ids = CustomerVisit.where(from_id:customer_id).pluck(:to_id)
     Customer.where(id:to_ids)
   end

   # 别人放问我
   def self.my_to(customer_id)
     from_ids = CustomerVisit.where(to_id:customer_id).pluck(:from_id)
     Customer.where(id:from_ids)
   end

end
