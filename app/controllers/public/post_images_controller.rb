class Public::PostImagesController < ApplicationController
  def new
      @post_image = PostImage.new
  end
  
  def create
      @post_image = PostImage.new(post_image_params)
      @post_image.user_id = current_user.id
      # 受け取った値を,で区切って配列にする
      tag_list = params[:post_image][:name].split(',')
      if @post_image.save
         @post_image.save_tags(tag_list)
          flash[:notice] = "You have created post successfully."
          redirect_to post_image_path(@post_image.id)
      else
          flash.now[:alert] = "You have Failed to post."
          render :new
      end
  end

  def index
  end

  def show
  end

  def edit
  end
  
  private
  def post_image_params
      params.require(:post_image).permit(:body, :image)
  end
  
end
