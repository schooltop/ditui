class AddCityToMarkes < ActiveRecord::Migration[5.1]
  def change
    add_column :markets, :country, :string, comment: "国家"
    add_column :stores, :country, :string, comment: "国家"
    add_column :markets, :city, :string, comment: "城市"
    add_column :stores, :city, :string, comment: "城市"

    add_column :vendors, :region, :string, comment: "区"
    add_column :vendors, :street, :string, comment: "街道"
    add_column :vendors, :street_no, :string, comment: "门牌号"
    add_column :vendors, :address, :string, comment: "详细地址"
    add_column :vendors, :city, :string, comment: "城市"
    add_column :vendors, :province, :string, comment: "省市"
    add_column :vendors, :country, :string, comment: "国家"
  end
end
