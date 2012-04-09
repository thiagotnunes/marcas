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
    color 'progress-danger'
    lifecycle 'manual'
  end

  factory :order_type do
    sequence(:name) { |n| "name#{n}" }
  end

  factory :service do
    sequence(:name) { |n| "name#{n}" }
    price 100.0
    association :order_type
  end

  factory :order_attachment do
    sequence(:file) { |n| "file#{n}" }
  end
  
  factory :trademark_order do
    name "name"
    segment "segment"
    subsegment "subsegment"
    association :user
    association :order_status
    association :service
    association :invoice
  end

  factory :invoice do
  end

  factory :order do
    association :user
    association :order_status
    association :service
    association :invoice
  end
end
