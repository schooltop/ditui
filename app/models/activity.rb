class Activety < ApplicationRecord
  has_many :activity_details
  has_many :orders
end
