FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "john#{n}" }
    password 'password'
    password_confirmation 'password'
    sequence(:email) { |n| "john#{n}@doe.com" }
  end

  factory :customer, :parent => :user do
    role "customer"
  end

  factory :admin, :parent => :user do
    role "admin"
  end
end
