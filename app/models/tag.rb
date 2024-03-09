class Tag < ApplicationRecord
  has_many :post_tag_relations, dependent: :destroy
  # 中間テーブル"post_tag_relations"を通してアソシエーション
  has_many :post_images, through: :post_tag_relations
  
  validate :name, presence:true, length:{maximum:50}
end
