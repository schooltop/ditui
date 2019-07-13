class OrderDetail < ApplicationRecord
  belongs_to :activity
  belongs_to :vendor
  belongs_to :activity_detail
end
