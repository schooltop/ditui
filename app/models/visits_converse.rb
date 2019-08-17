class VisitsConverse < ApplicationRecord
	has_many :customers
	#has_many :vendors
	# 游客留言

	def from
      User.find(self.from_id)
	end
	
end