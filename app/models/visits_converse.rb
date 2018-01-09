class VisitsConverse < ApplicationRecord
	has_many :customers
	#has_many :vendors

	def from
      User.find(self.from_id)
	end
	
end