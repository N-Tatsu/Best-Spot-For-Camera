class Tag < ApplicationRecord
  
  validates :name, presence:true, length:{maximum:50}
  
  has_many :post_tag_relations, dependent: :destroy
  has_many :post_images, through: :post_tag_relations
  
  # タグの検索
   def self.search_for(content, method)
      if method == 'perfect'
        Tag.where(name: content)
      elsif method == 'forward'
        Tag.where('name LIKE ?', content + '%')
      elsif method == 'backward'
        Tag.where('name LIKE ?', '%' + content)
      else
        Tag.where('name LIKE ?', '%' + content + '%')
      end
   end
    
  
  
end
