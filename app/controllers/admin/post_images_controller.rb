class Admin::PostImagesController < ApplicationController
  
  before_action :authenticate_admin!

  def show
    @post_image = PostImage.find(params[:id])
  end

end
