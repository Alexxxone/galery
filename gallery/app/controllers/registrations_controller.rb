class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource
    if resource.save_with_captcha
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
        tracking("sessions.create", {:user_id=> resource.id} )
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end

    else
      clean_up_passwords resource
      respond_with resource
    end
  end


  private
  def tracking (type='track_url',data = {:url=>request.url,:user_id=> current_user})
    ActiveSupport::Notifications.instrument(type,data) if !current_user.nil?
  end
end