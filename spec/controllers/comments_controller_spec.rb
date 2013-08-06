require 'spec_helper'


describe CommentsController do

  context "SUBSCRIBE AND CHECK_SUBSCRIBE action" do
    before :each do
      @pic = FactoryGirl.create(:picture)
      @user = FactoryGirl.create(:user)
    end

    it "logged user create comment" do
      sign_in @user
      post :create, :picture_id => @pic.id, :comment => { :body => 'New comment' }
      @user.comments.last.body.should == 'New comment'
      expect (redirect_to picture_path(@pic))
      flash[:notice].should == 'Comment was successfully created.'
    end
    it "NOT logged user create comment" do
      post :create, :picture_id => @pic.id, :comment => { :body => 'New comment' }
      @user.comments.count.should == 0
      response.should redirect_to(new_user_session_path)
    end
    it "logged user create TO LONG comment" do
      sign_in @user
      post :create, :picture_id => @pic.id, :comment => { :body => 'New comment'*30 }
      @user.comments.count.should == 0
      expect (redirect_to picture_path(@pic))
      flash[:alert].should == 'Comment create error.'
    end
  #def create
  #  @picture = Picture.find(params[:picture_id])
  #  @comment = current_user.comments.new(params[:comment])
  #  @comment.picture_id=@picture.id
  #
  #
  #  if @comment.save
  #    tracking('comments.create', {:comment => @comment,:user_id=>current_user.id} )
  #
  #    Pusher['test-channel'].trigger('test-event',comment: @comment.body.to_json,picture: @comment.picture.id.to_json)
  #    flash[:notice] = 'Comment was successfully created.'
  #  else
  #    flash[:alert] = 'Comment create error.'
  #  end
  #  redirect_to picture_path(@picture)
  #end


end
end