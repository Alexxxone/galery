class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  before_filter :set_user_language

  def set_user_language
    I18n.locale = 'en'
  end


end
