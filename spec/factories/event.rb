# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    eventable_id 1
    eventable_type 'Comment'
    user_id 1
  end
  factory :url_event, :parent => :event do
    eventable_id 1
    eventable_type 'Url'
    user_id 1
  end
  factory :comment_event, :parent => :event do
    eventable_id 1
    eventable_type 'Comment'
    user_id 1
  end
  factory :like_event, :parent => :event do
    eventable_id 1
    eventable_type 'Like'
    user_id 1
  end

end