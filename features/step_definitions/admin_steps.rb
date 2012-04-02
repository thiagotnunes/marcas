Given /^a administrator "(.*)" exists$/ do |username|
  user = FactoryGirl.build(:admin, :username => username, :email => "#{username}@marcaexpressa.com")
  user.save!
  user.activate!
end
