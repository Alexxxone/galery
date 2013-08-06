FactoryGirl.define do

  factory :comment do
    picture_id 1
    user_id 1
    sequence(:body) { |n| "tit#{n}" }
  end


end

