class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  before_filter :set_user_language
  before_filter  :tracking, :except => [:get_last_comments,:get_categories,:auth, :check_subscribe], :if => :user_signed_in?


  def set_user_language
    if session[:language]
      I18n.locale = session[:language]
    else
      I18n.locale = 'en'
    end

  end

  def tracking (type='track_url',data = {:url=>request.url,:user_id=> current_user})
    ActiveSupport::Notifications.instrument(type,data) if !current_user.nil?
  end

end
