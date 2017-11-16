class GpsLocation < ApplicationRecord
  belongs_to :customer
  has_many :customers_vendors

  def cover_img_path
  	self.cover_img ? Attachment.find(self.cover_img.to_i).path.url : "/assets/f10.jpg"
  end

  # 显示经纬度
  def latitude_longitude
    "#{self.latitude},#{self.longitude}"
  end
  
end
