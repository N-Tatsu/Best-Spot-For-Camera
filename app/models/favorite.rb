class Favorite < ApplicationRecord
  #バリデーション
  validates :user_id, uniqueness: {scope: :post_image_id}
  
  #関連付け
  belongs_to :user
  belongs_to :post_image
  
end
