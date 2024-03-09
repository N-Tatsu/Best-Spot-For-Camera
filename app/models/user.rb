class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  # sessions_controller.rbで記述したUser.guestのguestメソッドを定義してあげる
  # find_or_create_byは、データの検索と作成を自動的に判断して処理を行う、Railsのメソッド
  # 「!」を付与することで、処理がうまくいかなかった場合にエラーが発生するようになり、結果不具合を検知しやすくなる
  # SecureRandom.urlsafe_base64は、ランダムな文字列を生成するRubyのメソッドの一種
  GUEST_USER_EMAIL = "guest@example.com"
  
    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|    
        user.password = SecureRandom.urlsafe_base64
        user.name = "guestuser"
      end
    end
end
