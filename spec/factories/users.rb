# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
    factory :user do
      sequence(:email) { |n| "name#{n}@mail.ru" }
      password "123456"
      password_confirmation "123456"
      remember_me true
    end
end
