class AddCoverImgToGpsLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :gps_locations, :cover_img, :integer, comment: 'gps图片'
  end
end
