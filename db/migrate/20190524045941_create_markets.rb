class CreateMarkets < ActiveRecord::Migration[5.1]
  def change
    create_table :markets do |t|
      t.string "name",comment: "名称"
      t.text "content",comment: "描述"
      t.string "open_time", comment: "营业时间"
      t.string "map_link", comment: "地图链接"
      t.string "search_count", comment: "热度"
      t.string "tag", comment: "特色标签（美食，学校，商业中心）"
      t.string "crowd", comment: "主要人群属性（学生，白领）"
      t.string "cover_img", comment: "封面图片"
      t.string "province",comment: "省市"
      t.string "region",comment: "区"
      t.string "street",comment: "街道"
      t.string "street_no",comment: "门牌号"
      t.string "address",comment: "详细地址"
      t.string "latitude",comment: "经度"
      t.string "longitude",comment: "纬度"
      t.timestamps
    end
  end
end