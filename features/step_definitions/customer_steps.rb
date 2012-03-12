Given /^I am an existing customer "(.*)"$/ do |username|
  user = Factory.build(:customer, :username => username)
  user.save!
  user.activate!
end
