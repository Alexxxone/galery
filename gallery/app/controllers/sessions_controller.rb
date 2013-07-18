class SessionsController < Devise::SessionsController

  def create
    super
    tracking("sessions.create", {:user_id=> current_user.id} )
  end

  def destroy
    super
    tracking("sessions.destroy", {:user_id=> current_user.id} )
  end

  def facebook
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
    tracking("sessions.create", {:user_id=>current_user.id} )
    redirect_to root_path
  end

  private
  def tracking (type='track_url',data = {:url=>request.url,:user_id=> current_user})
    ActiveSupport::Notifications.instrument(type,data) if !current_user.nil?
  end
end