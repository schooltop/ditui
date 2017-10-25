class CreateVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string "title"
      t.text "content"
      t.string "cover_img", comment: "cover"
      t.integer "category_id", comment: "category"
      t.integer "view_count", comment: "view_count"
      t.integer "seq", default: 10, comment: "seq"
      t.string "tag"	
      t.timestamps
    end
  end
end
