Given /^a customer "(.*)" exists$/ do |username|
  user = Factory.build(:customer, :username => username, :email => "#{username}@marcaexpressa.com")
  user.save!
  user.activate!
end

Given /^no customer exists$/ do
  User.destroy_all(:role => "customer")
end
