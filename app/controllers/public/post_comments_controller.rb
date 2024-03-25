class Public::PostCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
      post_image = PostImage.find(params[:post_image_id])
      comment = current_user.post_comments.new(post_comment_params)
      comment.post_image_id = post_image.id
      if  comment.save
          redirect_to request.referer, notice: "コメントを保存しました"
      else
          redirect_to request.referer, alert: "※コメントの保存に失敗しました"
      end
  end

  def destroy
      PostComment.find(params[:id]).destroy
      redirect_to request.referer
  end


  private

  def post_comment_params
      params.require(:post_comment).permit(:comment)
  end

end
