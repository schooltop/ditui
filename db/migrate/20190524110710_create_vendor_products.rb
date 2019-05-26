class CreateVendorProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :vendor_products do |t|
      t.references "vendor"	
      t.string "cover_img", comment: "封面图片"
      t.string "name", comment: "商品名称"
      t.text "content",comment: "描述"
      t.string "tag", comment: "特色标签"
      t.string "search_count", comment: "热度"
      t.string "goods_no", comment: "货号"
      t.string "package", comment: "商品规格"
      t.string "package_count", comment: "商品数量"
      t.string "price", comment: "客户价格"
      t.string "vendor_price", comment: "供应商价"
      t.string "market_price", comment: "市场价"
      t.datetime "start_time", comment: "开始时间"
      t.datetime "end_time", comment: "结束时间"
      t.integer "status", comment: "状态"
      t.timestamps
    end
  end
end