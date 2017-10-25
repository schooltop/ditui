class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string "name"
      t.text "content"
      t.integer "category_id", comment: "category"
      t.timestamps	
    end
  end
end
