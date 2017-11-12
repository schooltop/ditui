class AddBdIdToVendors < ActiveRecord::Migration[5.1]
  def change
  	add_column :vendors, :db_id, :integer, comment: 'bd'
  	add_column :vendors, :dealer_id, :integer, comment: '撮合'
  	add_column :vendors, :cs_id, :integer, comment: '客服'
  end
end
