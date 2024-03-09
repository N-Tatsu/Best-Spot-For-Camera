class AddIndexToPostTagRelations < ActiveRecord::Migration[6.1]
  def change
  end
  add_index :post_tag_relations, [:post_image_id,:tag_id],unique: true
end
