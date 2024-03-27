class Favorite < ApplicationRecord
  
  # 引数の"user_id"が既にテーブル内で重複していないかチェック
  # "scope"で"user_id"と"post_image_id"のペアが保存されているか判定
  validates :user_id, uniqueness: {scope: :post_image_id}

  belongs_to :user
  belongs_to :post_image

end
