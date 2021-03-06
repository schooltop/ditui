class VendorProductSpec < ApplicationRecord
  # 客户产品规格

  include Activeable
  
  belongs_to :vendor_product

  enum instock: {
    instock: 1,
    out_of_stock: 0
  }
  
end
