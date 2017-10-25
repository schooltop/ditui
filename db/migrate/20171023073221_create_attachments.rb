class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string "attachment_entity_type", limit: 64
      t.integer "attachment_entity_id"
      t.string "path"
      t.string "name"
      t.string "content_type"
      t.integer "file_size"
      t.string "created_by", limit: 64
      t.string "tag"
      t.timestamps
      t.index ["attachment_entity_id"], name: "attachments_entity_idx"		
    end
  end
end
