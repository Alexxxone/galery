class CommentsController < ApplicationController


  before_filter :authenticate_user!

  def create
    @picture = Picture.find(params[:picture_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.picture_id=@picture.id


    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment create error.'
    end
    redirect_to picture_path(@picture)
  end
end