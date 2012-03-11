MAIL_URL = /http:\/\/(.*)(\.)?$/

USERNAME = "John"
PASSWORD = "password"
EMAIL = "john@doe.com"

Given /^I am on the home page$/ do
  visit(home_url)
end

Given /^I am an existing customer$/ do
  user = User.new(:username => USERNAME, :password => PASSWORD, :password_confirmation => PASSWORD, :email => EMAIL)
  user.role = :customer
  user.save!
  user.activate!
end

Given /^I am logged in$/ do
  step "I am on the home page"
  step "I login"
end

Given /^I am a logged in customer$/ do
  step "I am an existing customer"
  step "I am logged in"
end

When /^I signup$/ do
  click_link("Sign up")
  fill_in("Username", :with => USERNAME)
  fill_in("Email", :with => EMAIL)
  fill_in("Password", :with => PASSWORD)
  fill_in("Password confirmation", :with => PASSWORD)
  click_button("Create User")
end

When /^I activate my account$/ do
  activation_mail = ActionMailer::Base.deliveries.last
  body = activation_mail.body
  match = MAIL_URL.match(body.to_s) 
  visit(match[0])
end

When /^I login$/ do
  login(PASSWORD)
end

When /^I update my password to "(.*)"$/ do |password|
  click_link(USERNAME)
  fill_in("Old password", :with => PASSWORD)
  fill_in("Password", :with => password)
  fill_in("Password confirmation", :with => password)
  click_button("Update User")
end

When /^I log out$/ do
  click_link("Log out")
end

When /^I forgot my password$/ do
  visit(login_path)
  click_link("Forgot Password?")
  fill_in("Email", :with => EMAIL)
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
  login(password)
  step "I should be logged in"
end

Then /^I should not be logged in$/ do
  page.should have_content("Sign up or Log in")
  page.should_not have_content(USERNAME)
  page.should_not have_content("My account")
end

def login(password)
  click_link("Log in")
  fill_in("Username", :with => USERNAME)
  fill_in("Password", :with => password)
  click_button("Log in")
end
