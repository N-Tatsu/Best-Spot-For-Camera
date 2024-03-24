class PostComment < ApplicationRecord

  validates :comment, length: { maximum: 50 }

  belongs_to :user
  belongs_to :post_image
end
