class MessagesController < ApplicationController


  def create
    message = Message.create(:sender_id => current_user.id, :receiver_id => params[:receiver_id], :text =>params[:text])
    user = User.where(:id => current_user.id).first

    if message.save
      Pusher["private-channel"].trigger("#{params[:event_name]}",message: message.text.to_json, user: user,:receiver_id =>params[:receiver_id])
    end
    render json: {}
  end

end
