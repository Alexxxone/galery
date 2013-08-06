FactoryGirl.define do

  factory :message do
    sequence(:text) { |n| "message #{n}" }
    sender_id ''
    receiver_id ''
  end

end

