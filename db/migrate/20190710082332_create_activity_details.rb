class CreateActivityDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_details do |t|
      t.references "activity"
      t.references "vendor",comment: "供货商"
      t.string "name",comment: "商品名称"
      t.string "cover_img", comment: "封面图片"
      t.string "package_info", comment: "包装规格"
      t.decimal "market_price", precision: 10, scale: 2, comment: "市场价"
      t.decimal "price", precision: 10, scale: 2, comment: "活动价"
      t.text "content",comment: "描述"
      t.integer "view_count", comment: "view_count"
      t.timestamps		
    end
  end
end
