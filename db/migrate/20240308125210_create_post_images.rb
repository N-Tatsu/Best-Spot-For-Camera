class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.integer :user_id, null: false
      t.string :body, null: false
      t.string :address, default: ""
      t.float :latitude, default: 0
      t.float :longitude, default: 0
      t.timestamps
    end
  end
end
