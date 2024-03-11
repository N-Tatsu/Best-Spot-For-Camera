class Public::PostImagesController < ApplicationController
  def new
      @post_image = PostImage.new
  end

  def create
      #byebug
      @post_image = PostImage.new(post_image_params)
      @post_image.user_id = current_user.id
      # 受け取った値を,で区切って配列にする
      tag_list = params[:post_image][:name].split('、')
      if @post_image.save!
          @post_image.save_tags(tag_list)
          flash[:notice] = "You have created post successfully."
          redirect_to post_images_path
      else
          flash.now[:alert] = "You have Failed to post."
          render :new
      end
  end

  def index
      @post_images = PostImage.all
      @user = User.all
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
         flash[:notice] = "You have edited post successfully."
         redirect_to post_image_path(@post_image)
      else
        flash.now[:alert] = "You have Failed to edit." 
        render :edit
      end
  end
      
      def destroy
          post_image = PostImage.find(params[:id])
          post_image.destroy
          redirect_to post_images_path
      end
  

  private
  def post_image_params
      params.require(:post_image).permit(:body, :image, :address)
  end

end
