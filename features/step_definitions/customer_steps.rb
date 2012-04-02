Given /^a customer "(.*)" exists$/ do |username|
  FactoryGirl.create(:customer, :username => username, :email => "#{username}@marcaexpressa.com")
end

Given /^an activated customer "(.*)" exists$/ do |username|
  user = FactoryGirl.build(:customer, :username => username, :email => "#{username}@marcaexpressa.com")
  user.save!
  user.activate!
end

Given /^no customer exists$/ do
  User.destroy_all(:role => "customer")
end
