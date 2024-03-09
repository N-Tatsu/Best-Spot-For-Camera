class AddIndexToTags < ActiveRecord::Migration[6.1]
  def change
  end
  add_index :tags, :name, unique:true
end
