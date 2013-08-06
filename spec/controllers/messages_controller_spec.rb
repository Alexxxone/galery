require 'spec_helper'


describe MessagesController do

  context "Message Controller" do
    before :each do
      @pic = FactoryGirl.create(:picture)
      @user = FactoryGirl.create(:user)
    end

    it "asd" do

    end

  end
end

  #def create
  #  message = Message.create(:sender_id => current_user.id, :receiver_id => params[:receiver_id], :text =>params[:text])
  #  user = User.where(:id => current_user.id).first
  #
  #  if message.save
  #    Pusher["private-channel"].trigger("#{params[:event_name]}",message: message.text.to_json, user: user,:receiver_id =>params[:receiver_id])
  #  end
  #  render json: {}
  #end