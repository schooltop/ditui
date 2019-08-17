class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
    	t.string "name",comment: "活动名称"
		t.string "activity_entity_type",comment: "活动类型"
        t.integer "activity_entity_id",comment: "活动开始时间"
        t.datetime "start_time",comment: "活动开始时间"
        t.datetime "end_time",comment: "活动结束时间"
		t.string "community_tags",comment: "定投社区"
		t.string "tag", comment: "特色标签（美食，学校，商业中心）"
        t.string "crowd", comment: "主要人群属性（学生，白领）"
        t.string "province",comment: "省市"
        t.string "region",comment: "区"
        t.string "street",comment: "街道"
		t.string "latitude",comment: "经度"
        t.string "longitude",comment: "纬度"
		t.text "content",comment: "活动总结"
		t.integer "view_count", comment: "view_count"
        t.timestamps	
    end
  end
end