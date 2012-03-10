FactoryGirl.define do
  factory :user do
    username 'john'
    password 'pass'
    password_confirmation 'pass'
    email 'john@doe.com'
  end

  factory :customer, :parent => :user do
    role :customer
  end

  factory :admin, :parent => :user do
    role :admin
  end
end
