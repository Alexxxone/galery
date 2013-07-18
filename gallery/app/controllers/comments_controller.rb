class CommentsController < ApplicationController

  before_filter :authenticate_user!


  def create
    @picture = Picture.find(params[:picture_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.picture_id=@picture.id


    if @comment.save
      tracking('comments.create', {:comment => @comment,:user_id=>current_user.id} )
      Pusher['test-channel'].trigger('test-event',comment: @comment.body.to_json,picture: @comment.picture.id.to_json)
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment create error.'
    end
    redirect_to picture_path(@picture)
  end

  private
  def tracking (type='track_url',data = {:url=>request.url,:user_id=> current_user})
    ActiveSupport::Notifications.instrument(type,data) if !current_user.nil?
  end

end