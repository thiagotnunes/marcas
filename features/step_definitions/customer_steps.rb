Given /^I am an existing customer "(.*)"$/ do |username|
  step "a customer \"#{username}\" exists"
end

Given /^a customer "(.*)" exists$/ do |username|
  user = Factory.build(:customer, :username => username, :email => "#{username}@marcaexpressa.com")
  user.save!
  user.activate!
end
