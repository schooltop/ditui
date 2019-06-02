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
      t.integer "instock", default: 1, comment: "0-无货，1-有货"
      t.boolean "locked", default: false, comment: "锁定状态"
      t.integer "origin", comment: "来源，后台上传，供应商自己上传"
      t.integer "hot_product", comment: "该公司热卖/置顶产品"
      t.integer "active", default: 1, comment: "是否有效， 0-否，1-是"
      t.integer "weight", default: 1, comment: "权重，用于计算推荐系数"
      t.timestamps
    end
  end
end