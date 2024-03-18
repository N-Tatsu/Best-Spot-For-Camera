class Admin::HomesController < ApplicationController
  
  before_action :authenticate_admin!
  
  def top
    @post_images = PostImage.all
  end
  
end
