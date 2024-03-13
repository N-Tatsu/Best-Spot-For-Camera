class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #ユーザー名を2文字以上20文字以内、一意性のバリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  #自己紹介を５０以下のバリデーション
  validates :introduction, length: { maximum: 50 }

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

  #ゲストログイン用のゲストログイン用のメールアドレス・パスワード・ユーザー名を設定
    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64  #パスワードはランダムで発行
        user.name = "guestuser"
      end
    end

    #初期プロフィール画像
    def get_profile_image(width, height)
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
        self.profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width, height]).processed
    end

    # "user"を選択した時の検索の流れ
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



