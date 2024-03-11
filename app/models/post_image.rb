class PostImage < ApplicationRecord
    #バリデーション
    validates :address, presence: true
    geocoded_by :address
    after_validation :geocode
    
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

    # 引数の"user_id"が既にテーブル内で重複していないかチェック
    # "scope"で"user_id"と"post_image_id"のペアが保存されているか判定
    #validates :user_id, uniqueness: {scope: :post_image_id}

    
end
