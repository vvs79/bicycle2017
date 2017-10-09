FactoryGirl.define do
  factory :user do
  	login "login"
    sequence(:email) { |i| "mail#{i}@mail.com" }
    password "123456"
  end
end