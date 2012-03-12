Given /^I am an existing administrator "(.*)"$/ do |username|
  step "a administrator \"#{username}\" exists"
end

Given /^a administrator "(.*)" exists$/ do |username|
  user = Factory.build(:admin, :username => username, :email => "#{username}@marcaexpressa.com")
  user.save!
  user.activate!
end
