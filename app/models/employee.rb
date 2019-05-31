class Employee < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable#, :trackable, :validatable

  def self.get_by_name(id)
    return '客户' if id.to_i <=0
    Rails.cache.fetch("employee_#{id}", expires_in: 30.minute) do
      Employee.find_by_id(id)&.real_name
    end
  end       

end
