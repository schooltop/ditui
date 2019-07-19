class Community < ApplicationRecord
  # 社区
  belongs_to :bd, class_name: 'Employee', foreign_key: 'bd_id'
  belongs_to :trader, class_name: 'Employee', foreign_key: 'dealer_id'
  belongs_to :cs, class_name: 'Employee', foreign_key: 'cs_id'
  belongs_to :agent, class_name: 'Employee', foreign_key: 'agent_id'

end
