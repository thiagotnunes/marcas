MAIL_URL = /http:\/\/(.*)(\.)?$/

Given /^I am on the home page$/ do
  visit(home_url)
end

When /^I signup$/ do
  click_link("Sign up")
  fill_in("Username", :with => "John")
  fill_in("Email", :with => "john@doe.com")
  fill_in("Password", :with => "password")
  fill_in("Password confirmation", :with => "password")
  click_button("Create User")
end

When /^I activate my account$/ do
  activation_mail = ActionMailer::Base.deliveries.last
  body = activation_mail.body
  match = MAIL_URL.match(body.to_s) 
  visit(match[0])
end

When /^I login$/ do
  click_link("Log in")
  fill_in("Username", :with => "John")
  fill_in("Password", :with => "password")
  click_button("Log in")
end

When /^I forgot my password$/ do
  visit(login_path)
  click_link("Forgot Password?")
  fill_in("Email", :with => "john@doe.com")
  click_button("Reset my password")
end

Then /^I should receive a notification to activate my user$/ do
  page.should have_content("User was successfully created. A mail has been sent to your email, please check it to activate your account.");
end

Then /^my account should be active$/ do
  page.should have_content("User was successfully activated.")
end

Then /^I should be logged in$/ do
  page.should have_content("Logged in as John. Log out")
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should receive reset password instructions in my email$/ do
  page.should have_content("Instructions have been sent to your email.")
  reset_password_mail = ActionMailer::Base.deliveries.last
  match = MAIL_URL.match(reset_password_mail.body.to_s)
  visit(match[0])
end

Then /^I should be able to reset my password to "(.*)"$/ do |password|
  fill_in("Password", :with => password)
  fill_in("Password confirmation", :with => password)
  click_button("Update User")
end

Then /^I should be able to login with "(.*)"$/ do |password|
  fill_in("Username", :with => "John")
  fill_in("Password", :with => password)
  click_button("Log in")
end
