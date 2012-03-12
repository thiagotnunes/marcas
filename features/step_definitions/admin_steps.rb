Given /^I am an existing administrator (.*)$/ do |username|
  user = Factory.build(:admin, :username => username, :password => PASSWORD)
  user.save!
  user.activate!
end
