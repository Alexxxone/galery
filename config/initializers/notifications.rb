ActiveSupport::Notifications.subscribe 'pictures.like' do |name, start, finish, id, payload|
  Event.create(:eventable => payload[:like],:user_id => payload[:user_id])
end

ActiveSupport::Notifications.subscribe 'comments.create' do |name, start, finish, id, payload|
  Event.create(:eventable => payload[:comment],:user_id => payload[:user_id])
end

ActiveSupport::Notifications.subscribe 'track_url' do |name, start, finish, id, payload|
  url =  Url.find_or_create_by_url(payload[:url])
  Event.create(:eventable => url, :user_id => payload[:user_id][:id])
end

ActiveSupport::Notifications.subscribe 'sessions.destroy' do |name, start, finish, id, payload|
  Event.create(:eventable_id => payload[:user_id], :eventable_type => payload["Sign_out"], :user_id => payload[:user_id])
end

ActiveSupport::Notifications.subscribe 'sessions.create' do |name, start, finish, id, payload|
  Event.create(:eventable_id => payload[:user_id], :eventable_type => payload["Sign_in"], :user_id => payload[:user_id])
end
