class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.string "order_no",comment: "订单号"
      t.string "order_detail_no",comment: "采购订单号"
      t.references "order",comment: "订单"
      t.references "vendor",comment: "供货商"
      t.references "activity_detail"
      t.decimal "amount", precision: 10, scale: 2, comment: "客户金额"
      t.decimal "vendor_amount", precision: 10, scale: 2, comment: "供应商金额"
      t.decimal "revive_amont", precision: 10, scale: 2, comment: "已收金额"
      t.decimal "payment_amount", precision: 10, scale: 2, comment: "已付金额"
      t.integer "payment_status", comment: "收款状态"
      t.integer "shipping_status", comment: "发货状态"
      t.integer "shipping_address", comment: "发货状态"
      t.integer "status", comment: "采购订单状态"
      t.text "content",comment: "描述"
    end
  end
end