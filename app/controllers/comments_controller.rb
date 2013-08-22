class CommentsController < ApplicationController

  before_filter :authenticate_user!


  def create
    @picture = Picture.find(params[:picture_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.picture_id=@picture.id

    $redis.set(:comment, @comment.id, :body, @comment.body)

    if @comment.save
      sender_email = @comment.user.email
      tracking('comments.create', {:comment => @comment,:user_id=>current_user.id} )
      Pusher['test-channel'].trigger('test-event',comment: @comment,:sender_email => sender_email, :picture => @picture.id)
    end
    respond_to do |format|
      format.js
    end
  end

end