class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
	    t.integer "vendor_id", comment: "公司"
	    t.integer "user_id", comment: "关联的登录账号"
	    t.string "name", comment: "名称"
	    t.string "email", comment: "邮箱"
	    t.string "title", comment: "职位"
	    t.string "tel", comment: "座机"
	    t.string "mobile", comment: "手机"
	    t.string "fax", comment: "传真"
	    t.integer "gender", default: 0, comment: "性别, 0-男, 1-女"
	    t.date "dob", comment: "生日"
	    t.string "country", limit: 100
	    t.string "province", limit: 100
	    t.string "city", limit: 100
	    t.integer "email_notify", default: 4095, comment: "bitmap, 1-询盘，2-报价，3-订单合同"
	    t.integer "verified_email", default: 0, comment: "是否已验证邮箱, 0-否，1-是"
	    t.integer "verified_mobile", default: 0
	    t.boolean "buy_locked", default: false
	    t.boolean "sale_locked", default: false
	    t.integer "certification", default: 0, comment: "0-未认证，1-认证"
	    t.integer "origin", comment: "来源"
	    t.integer "active", default: 1
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.string "created_by", limit: 64
	    t.boolean "buyer", default: false, comment: "买家"
	    t.boolean "vendor", default: false, comment: "卖家"
	    t.text "note", comment: "描述备注"
	    t.index ["vendor_id"], name: "index_contacts_on_vendor_id"	
    end
  end
end
