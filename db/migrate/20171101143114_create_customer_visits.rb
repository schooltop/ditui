class CreateCustomerVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_visits do |t|
      t.integer "from_id", comment: "访问者"
      t.integer "to_id", comment: "被访问者" 	
      t.integer "view_count", comment: "访问次数"
      t.timestamps
    end
  end
end
