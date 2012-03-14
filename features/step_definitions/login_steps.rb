MAIL_URL = /http:\/\/(.*)(\.)?$/

USERNAME = "john"
PASSWORD = "password"
EMAIL = "john@marcaexpressa.com"

Given /^I am on the forgot password page$/ do
  visit(new_password_reset_url)
end

Given /^I am on the change password page$/ do
  visit(edit_password_url(User.find_by_username(USERNAME)))
end

Given /^I am on the signup page$/ do
  visit(signup_url)
end

Given /^I am on the login page$/ do
  visit(login_url)
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
  click_link("signup")
  fill_in("user_username", :with => USERNAME)
  fill_in("user_email", :with => EMAIL)
  fill_in("user_password", :with => PASSWORD)
  fill_in("user_password_confirmation", :with => PASSWORD)
  click_button("commit")
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

When /^I login as a administrator$/ do
  step "I login"
end

When /^I update my password to "(.*)"$/ do |password|
  click_link(USERNAME)
  click_link("change_password")
  fill_in("user_old_password", :with => PASSWORD)
  fill_in("user_password", :with => password)
  fill_in("user_password_confirmation", :with => password)
  click_button("commit")
end

When /^I miss my current password$/ do
  fill_in("user_old_password", :with => "invalid password")
  click_button("commit")
end

When /^I log out$/ do
  click_link("logout")
end

When /^I forgot my password$/ do
  visit(login_path)
  click_link("forgot_password")
  fill_in("email", :with => EMAIL)
  click_button("commit")
end

When /^I go to reset password page$/ do
  reset_password_mail = ActionMailer::Base.deliveries.last
  match = MAIL_URL.match(reset_password_mail.body.to_s)
  visit(match[0])
end

Then /^I reset my password to "(.*)"$/ do |password|
  fill_in("user_password", :with => password)
  fill_in("user_password_confirmation", :with => password)
  click_button("commit")
end

Then /^I should receive a notification to activate my user$/ do
  page.should have_content(I18n.t('user.messages.created'));
end

Then /^my account should be active$/ do
  page.should have_content(I18n.t('user.messages.activated'))
  user = User.find_by_username(USERNAME)
  user.active?.should be_true
end

Then /^I should be logged in$/ do
  page.should have_content(I18n.t('user.navbar.logged_as') + ' ' + USERNAME + '. ' + I18n.t('user.navbar.logout'))
end

Then /^I should not be logged in$/ do
  page.should have_content(I18n.t('make') + ' ' + I18n.t('user.navbar.signup') + ' ' + I18n.t('or') + ' ' + I18n.t('user.navbar.login'))
  page.should_not have_content(USERNAME)
end

Then /^I should not be registered$/ do
  User.find_by_username(USERNAME).should be_nil
end

def login(username, password)
  click_link("login")
  fill_in("username", :with => username)
  fill_in("password", :with => password)
  click_button("commit")
end
