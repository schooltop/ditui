class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
	  t.string :name, comment: "名称"
	  t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      ## Rememberable
      t.datetime :remember_created_at
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.integer "gender", comment: "性别 0:男 1:女"
	  t.string "mobile", limit: 30, comment: "手机"
      t.string "qq", limit: 30, comment: "QQ"
      t.string "office_tel", limit: 30, comment: "公司电话"
      t.date "dob", comment: "生日"
      # Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
