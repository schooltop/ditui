class Order < ApplicationRecord
  belongs_to :activity
  belongs_to :community
  belongs_to :customer
  belongs_to :agent, class_name: 'Employee', foreign_key: 'agent_id'
end
