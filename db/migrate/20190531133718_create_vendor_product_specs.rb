class CreateVendorProductSpecs < ActiveRecord::Migration[5.1]
  def change
    create_table :vendor_product_specs do |t|
      t.integer "vendor_product_id", comment: "供应商产品信息"
      t.integer "instock", default: 1, comment: "0-无货，1-有货"
      t.string "spec_info", comment: "规格"
      t.string "quantity", comment: "库存数量"
      t.integer "active", default: 1, comment: "是否有效， 0-否，1-是"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "created_by", limit: 64
      t.string "note", limit: 500, comment: "产品备注"
      t.string "price", comment: "客户价格"
      t.string "vendor_price", comment: "供应商价"
      t.string "market_price", comment: "市场价"
      t.index ["vendor_product_id"], name: "index_vendor_products_on_vendor_product_id"
    end
  end
end