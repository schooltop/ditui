class CreateVisitesConverses < ActiveRecord::Migration[5.1]
  def change
    create_table :visits_converses do |t|
    	t.integer "from_id", comment: "发送信息id"
        t.integer "to_id", comment: "接受信息id"
        t.string "converse", comment: "信息内容"
    end
  end
end
