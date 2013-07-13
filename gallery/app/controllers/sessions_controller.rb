class SessionsController < ApplicationController

  def create
      auth = (env['omniauth.auth'])
      @user = User.find_or_create_by_uid( auth['uid']) do |user|
        user.provider = auth.provider
        user.uid=auth.uid
        user.email=auth.info.email
        user.password=Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
      sign_in @user
      redirect_to session[:return_to]
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end