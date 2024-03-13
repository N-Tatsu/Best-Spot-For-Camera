class Tag < ApplicationRecord
  
  validates :name, presence:true, length:{maximum:50}
  
  has_many :post_tag_relations, dependent: :destroy
  # 中間テーブル"post_tag_relations"を通してアソシエーション
  has_many :post_images, through: :post_tag_relations
  
   def self.search_for(content, method)
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'forward'
        User.where('name LIKE ?', content + '%')
      elsif method == 'backward'
        User.where('name LIKE ?', '%' + content)
      else
        User.where('name LIKE ?', '%' + content + '%')
      end
   end
    
  
  
end
