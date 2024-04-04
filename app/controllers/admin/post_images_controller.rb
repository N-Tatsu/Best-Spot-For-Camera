class Admin::PostImagesController < ApplicationController

  before_action :authenticate_admin!

  def show
      @post_image = PostImage.find(params[:id])
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
         redirect_to admin_post_image_path(@post_image)
      else
        flash.now[:alert] = "投稿内容を変更できていません"
        render :edit
      end
  end

  def destroy
      post_image = PostImage.find(params[:id])
      post_image.destroy
      redirect_to admin_root_path
  end


  private

  def post_image_params
    params.require(:post_image).permit(:body, :image, :address)
  end
end
