class CreateGpsLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :gps_locations do |t|
      t.string "latitude",comment: "jingdu"
      t.string "longitude",comment: "weidu"	
      t.references "customer"
      t.timestamps	
    end
  end
end
