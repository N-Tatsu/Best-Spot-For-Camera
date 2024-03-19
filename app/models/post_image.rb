class PostImage < ApplicationRecord
    #バリデーション
    # validates :address, presence: true
    #addressカラムの内容を緯度・経度に変換することを指定
    geocoded_by :address
    #バリデーションの実行後に変換処理を実行して、latitudeカラム・longitudeカラムに緯度・経度の値が入力される
    after_validation :geocode

    validates :body, length: { maximum: 25 }, presence: true
    # validates :image, presence: true


    #関連付け
    has_one_attached :image
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    has_many :post_tag_relations, dependent: :destroy
    # 中間テーブル"post_tag_relations"を通してアソシエーション
    has_many :tags, through: :post_tag_relations



    # 引数で渡された”user_id”がFavoriteテーブルに存在するかどうか調べる
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end


    def save_tags(tags)
        # タグが存在していれば、タグの名前を配列として全て取得する
        current_tags = self.tags.pluck(:name) unless self.tags.nil?
        # 現在取得したタグから送られてきたタグを除いてoldtagとする
        old_tags = current_tags - tags
        # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
        new_tags = tags - current_tags

        # 古いタグを消す
        old_tags.each do |old_name|
            self.tags.delete Tag.find_by(name: old_name)
        end

        # 新しいタグを保存
        new_tags.each do |new_name|
            tag = Tag.find_or_create_by(name: new_name)
            self.tags << tag
        end

    end

     def liked_post_iamges(user, page, per_page) # 1. モデル内での操作を開始
        includes(:post_images_favorites) # 2. post_favorites テーブルを結合
         .where(favorites: { user_id: user.id }) # 3. ユーザーがいいねしたレコードを絞り込み
         .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
         .page(page) # 5. ページネーションのため、指定ページに表示するデータを選択
         .per(per_page) # 6. ページごとのデータ数を指定
     end

    def get_image(width, height)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
        self.image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image.variant(resize_to_limit: [width, height]).processed
    end

end
