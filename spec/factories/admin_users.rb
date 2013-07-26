# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
    sequence(:email) { |n| "admin#{n}@mail.ru" }
    password "123456"
    password_confirmation "123456"
    remember_me true
  end
end
