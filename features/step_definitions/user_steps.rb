ACTIVATION_TOKEN = /http:\/\/(.*)$/

Given /^I am on the home page$/ do
  visit(home_url)
end

When /^I signup$/ do
  click_link("Sign up")
  fill_in("Username", :with => "John")
  fill_in("Email", :with => "john@doe.com")
  fill_in("Password", :with => "password")
  fill_in("Password confirmation", :with => "password")
  click_on("Create User")
end

When /^I activate my account$/ do
  activation_mail = ActionMailer::Base.deliveries.last
  body = activation_mail.body
  match = ACTIVATION_TOKEN.match(body.to_s) 
  visit(match[0])
end

When /^I login$/ do
  click_link("Log in")
  fill_in("Username", :with => "John")
  fill_in("Password", :with => "password")
  click_on("Log in")
end

Then /^I should receive a notification to activate my user$/ do
  page.should have_content("User was successfully created. A mail has been sent to your email, please check it to activate your account.");
end

Then /^my account should be active$/ do
  page.should have_content("User was successfully activated.")
end
