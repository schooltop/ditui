class Vendor < ApplicationRecord
  has_many :comments
  has_and_belongs_to_many :customers, join_table: :roles_permissions

  def cover_img_path
  	self.cover_img ? Attachment.find(self.cover_img.to_i).path.url : "/assets/f10.jpg"
  end

  def self.like_vendor(latitude,longitude)
  	Vendor.find_by_sql("select *, abs(latitude-#{latitude}) as min_latitude , abs(longitude-#{longitude}) as min_longitude  
  		from vendors  
  		order by min_latitude, min_longitude 
  		limit 10 ")
  end

end
