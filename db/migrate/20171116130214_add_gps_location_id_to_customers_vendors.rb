class AddGpsLocationIdToCustomersVendors < ActiveRecord::Migration[5.1]
  def change
  	add_column :customers_vendors, :gps_location_id, :integer, comment: '图片gps关联'
  end
end
