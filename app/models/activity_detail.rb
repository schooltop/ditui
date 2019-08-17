class ActivetyDetail < ApplicationRecord
  belongs_to :activity
  has_many :order_details
end
