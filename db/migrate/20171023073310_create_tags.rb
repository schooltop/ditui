class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string   "tag_entity_type"	
      t.integer   "tag_entity_id"
      t.string   "name"
      t.integer  "tag_category", default: 0 , comment: '0:general／1:man_add/2:thing_add/3:merge_tag' 
      t.timestamps	
    end
  end
end
