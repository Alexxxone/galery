class CommentsController < ApplicationController

  before_filter :authenticate_user!


  def create
    @picture = Picture.find(params[:picture_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.picture_id=@picture.id


    if @comment.save
      #@comments = Comment.preload([:user,:picture]).where(:picture_id=>@picture.id).order('created_at DESC').page(params[:page])
      sender_email = @comment.user.email
      tracking('comments.create', {:comment => @comment,:user_id=>current_user.id} )
      Pusher['test-channel'].trigger('test-event',comment: @comment,:sender_email => sender_email)
    end
    respond_to do |format|
      format.js
    end
  end

end