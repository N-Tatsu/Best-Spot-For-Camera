class Admin::TagsController < ApplicationController

  before_action :authenticate_admin!
  def index
      @tags = Tag.page(params[:page]).per(10)
  end

  def destroy
      @tag = Tag.find(params[:id])
      @tag.destroy
      redirect_to admin_tags_path
  end
end
