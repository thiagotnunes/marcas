FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "john#{n}" }
    password 'password'
    password_confirmation { |u| u.password }
    sequence(:email) { |n| "john#{n}@doe.com" }
  end

  factory :customer, :parent => :user do
    role "customer"
  end

  factory :admin, :parent => :user do
    role "admin"
  end

  factory :order_status do
    sequence(:status) { |n| "status#{n}" }
    color "#000000"
    first_status 0
  end

  factory :order_type do
    sequence(:name) { |n| "name#{n}" }
  end

  factory :service do
    sequence(:name) { |n| "name#{n}" }
    price 100.0
    association :order_type
  end
end
