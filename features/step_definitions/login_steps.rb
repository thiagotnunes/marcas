MAIL_URL = /http:\/\/(.*)(\.)?$/

USERNAME = "john"
PASSWORD = "password"
EMAIL = "john@doe.com"

Given /^I am on the home page$/ do
  visit(home_url)
end

Given /^I am logged in$/ do
  step "I am on the home page"
  step "I login"
end

Given /^I am a logged in customer$/ do
  step "I am an existing customer \"#{USERNAME}\""
  step "I am logged in"
end

Given /^I am a logged in administrator$/ do
  step "I am an existing administrator \"#{USERNAME}\""
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
  login(USERNAME, PASSWORD)
end

When /^I login with "(.*)"$/ do |password|
  login(USERNAME, password)
end

When /^I login as a administrator(.*)$/ do
  login(USERNAME, PASSWORD)
end

When /^I update my password to "(.*)"$/ do |password|
  click_link(USERNAME)
  click_link("Change password")
  fill_in("Old password", :with => PASSWORD)
  fill_in("Password", :with => password)
  fill_in("Password confirmation", :with => password)
  click_button("Update password")
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

When /^I follow reset password url received by email$/ do
  reset_password_mail = ActionMailer::Base.deliveries.last
  match = MAIL_URL.match(reset_password_mail.body.to_s)
  visit(match[0])
end

Then /^I reset my password to "(.*)"$/ do |password|
  fill_in("Password", :with => password)
  fill_in("Password confirmation", :with => password)
  click_button("Update User")
end

Then /^I should receive a notification to activate my user$/ do
  page.should have_content("User was successfully created. A mail has been sent to your email, please check it to activate your account.");
end

Then /^my account should be active$/ do
  page.should have_content("User was successfully activated.")
  user = User.find_by_username(USERNAME)
  user.active?.should be_true
end

Then /^I should be logged in$/ do
  page.should have_content("Logged in as #{USERNAME}. Log out")
end

Then /^I should not be logged in$/ do
  page.should have_content("Sign up or Log in")
  page.should_not have_content(USERNAME)
  page.should_not have_content("My account")
end

def login(username, password)
  click_link("Log in")
  fill_in("Username", :with => username)
  fill_in("Password", :with => password)
  click_button("Log in")
end
