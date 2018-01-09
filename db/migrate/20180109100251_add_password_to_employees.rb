class AddPasswordToEmployees < ActiveRecord::Migration[5.1]
  def change
  	add_column :employees, :reset_password_token, :string
  	add_column :employees, :reset_password_sent_at, :datetime
  end
end
