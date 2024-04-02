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

  end

  def destroy

  end
end
