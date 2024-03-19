class Public::PostImagesController < ApplicationController

  before_action :authenticate_user!

  def new
      @post_image = PostImage.new
  end

  def create
      #byebug
      @post_image = PostImage.new(post_image_params)
      @post_image.user_id = current_user.id
      # 受け取った値を,で区切って配列にする
      tag_list = params[:post_image][:name].split('、')
      result = Geocoder.search(params[:post_image][:address]).first
      if result.present?
          @post_image.latitude = result.latitude
          @post_image.longitude = result.longitude
      end
      if @post_image.save!
          @post_image.save_tags(tag_list)
          flash[:notice] = "投稿に成功しました"
          redirect_to post_images_path
      else
          flash.now[:alert] = "投稿に失敗しました"
          render :new
      end
  end

  def index
    respond_to do |format|
      format.html do
        @user = User.all
        @post_images = PostImage.page(params[:page])
      end
      format.json do
        @user = User.all
        @post_images = PostImage.page(params[:page])
      end
    end
  end

  def show
      @post_image = PostImage.find(params[:id])
      @tag_list = @post_image.tags.pluck(:name).join(',')
      @post_image_tags = @post_image.tags
      @post_comment = PostComment.new
  end

  def edit
      @post_image = PostImage.find(params[:id])
      @tag_list = @post_image.tags.pluck(:name).join(',')
  end

  def update
      @post_image = PostImage.find(params[:id])
      tag_list=params[:post_image][:name].split('、')
      if @post_image.update(post_image_params)
         @post_image.save_tags(tag_list)
         flash[:notice] = "投稿内容を変更しました"
         redirect_to post_image_path(@post_image)
      else
        flash.now[:alert] = "投稿内容を変更できていません"
        render :edit
      end
  end

  def destroy
      post_image = PostImage.find(params[:id])
      post_image.destroy
      redirect_to post_images_path
  end

  def search_tag
      @tag_list = Tag.all  #検索結果画面でもタグ一覧表示
      @tag = Tag.find(params[:tag_id])  #検索されたタグを受け取る
      @post_images = @tag.post_images  #検索されたタグに紐づく投稿を表示
  end


  private
  def post_image_params
      params.require(:post_image).permit(:body, :image, :address)
  end

end
