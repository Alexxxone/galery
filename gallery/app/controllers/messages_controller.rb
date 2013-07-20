class MessagesController < ApplicationController

  def create
    message = Message.create(:sender_id => current_user.id, :receiver_id => params[:receiver_id], :text =>params[:text])
    user = User.where(:id => current_user.id).first
    render json: {}
    if message.save
      Pusher.url = "http://40c797d047b5b2d43e30:86cd1b06995f13eb46d6@api.pusherapp.com/apps/49832"
      Pusher['private-channel'].trigger('pri-event',message: message.text.to_json, user: user)
    end
  end
end