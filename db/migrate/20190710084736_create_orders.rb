class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string "order_no",comment: "订单号"
      t.references "activity", comment: "活动"
      t.references "community", comment: "社区"
      t.references "customer", comment: "客户"
      t.integer "agent_id", comment: "代理商"
      t.text "content",comment: "描述"
      t.decimal "amount", precision: 10, scale: 2, comment: "应收金额"
      t.decimal "revive_amont", precision: 10, scale: 2, comment: "已收金额"
      t.integer "revive_status", comment: "收款状态"
      t.integer "status", comment: "客户订单状态"
    end
  end
end