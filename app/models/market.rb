class Market < ApplicationRecord
  has_many :vendors
  has_many :attachments, as: :attachment_entity
  # 大商圈

  def cover_img_path
  	self.cover_img ? Attachment.find(self.cover_img.to_i).path.url : "/assets/f10.jpg"
  end

end