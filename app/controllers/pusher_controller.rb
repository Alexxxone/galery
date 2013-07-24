class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action

  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render :json =>response.to_json, :callback => params[:callback]
    else
      render :text => "Forbidden", :status => '403'
    end
  end
end
