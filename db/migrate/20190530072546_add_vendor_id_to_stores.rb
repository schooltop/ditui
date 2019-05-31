class AddVendorIdToStores < ActiveRecord::Migration[5.1]
  def change
  	add_column :stores, :vendor_id, :integer, comment: '公司'
  end
end
