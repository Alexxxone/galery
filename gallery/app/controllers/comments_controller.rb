class CommentsController < ApplicationController

  before_filter :authenticate_user!


  def create
    @picture = Picture.find(params[:picture_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.picture_id=@picture.id


    if @comment.save
      tracking('comments.create', {:comment => @comment,:user_id=>current_user.id} )
      Pusher.url = "http://40c797d047b5b2d43e30:86cd1b06995f13eb46d6@api.pusherapp.com/apps/49832"
      Pusher['test-channel'].trigger('test-event',comment: @comment.body.to_json,picture: @comment.picture.id.to_json)
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment create error.'
    end
    redirect_to picture_path(@picture)
  end

end