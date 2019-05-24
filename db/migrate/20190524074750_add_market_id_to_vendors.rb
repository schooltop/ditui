class AddMarketIdToVendors < ActiveRecord::Migration[5.1]
  def change
  	add_column :vendors, :market_id, :integer, comment: '商场'
  end
end
