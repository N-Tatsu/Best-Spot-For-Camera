class Admin::PostImagesController < ApplicationController

  def show
    @post_image = PostImage.find(params[:id])
  end

end
