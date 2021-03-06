class Vendor < ApplicationRecord
  has_many :comments
  has_many :customers_vendors
  has_many :vendor_products
  belongs_to :market
  belongs_to :category
  has_one :store
  has_many :contacts
  has_many :attachments, as: :attachment_entity
  has_and_belongs_to_many :customers, join_table: :customers_vendors

  belongs_to :bd, class_name: 'Employee', foreign_key: 'bd_id'
  belongs_to :trader, class_name: 'Employee', foreign_key: 'dealer_id'
  belongs_to :cs, class_name: 'Employee', foreign_key: 'cs_id'

  def cover_img_path
  	self.cover_img ? Attachment.find(self.cover_img.to_i).path.url : "/assets/f10.jpg"
  end

  def self.view_count_top
    order(view_count: :desc).limit(5)
  end

  def self.like_vendor(latitude,longitude)
  	Vendor.find_by_sql("select abs(latitude-#{latitude}) as min_latitude , abs(longitude-#{longitude}) as min_longitude , vendors.* 
  		from vendors  
  		order by min_latitude , min_longitude ,created_at desc
  		limit 10 ")
  end

end