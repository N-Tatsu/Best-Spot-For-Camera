class Admin::ReviewsController < ApplicationController
  def index
    @post_comments = PostComment.all
    @users = User.all
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_reviews_path
  end
end
