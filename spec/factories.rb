FactoryGirl.define do
  factory :user do
    username 'john'
    password 'password'
    password_confirmation 'password'
    email 'john@doe.com'
  end

  factory :customer, :parent => :user do
    role :customer
  end

  factory :admin, :parent => :user do
    role :admin
  end
end
