class CreateCustomersVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :customers_vendors do |t|
      t.references "customer"
      t.references "vendor"	
      t.integer "view_count", comment: "view_count"
      t.timestamps	
    end
  end
end
