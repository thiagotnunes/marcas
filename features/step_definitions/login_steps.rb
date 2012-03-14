MAIL_URL = /http:\/\/(.*)(\.)?$/

DEFAULT_PASSWORD = "password"

Given /^an activated customer "(.*)"$/ do |username|
  user = create_customer(username)
  user.activate!
  ActionMailer::Base.deliveries.clear
end

Given /^an activated admin "(.*)"$/ do |username|
  user = create_admin(username)
  user.activate!
  ActionMailer::Base.deliveries.clear
end

Given /^I am on the signup page$/ do
  visit(signup_url)
end

Given /^I am on the login page$/ do
  visit(login_url)
end


Given /^no user exist$/ do
  User.destroy_all
end

Given /^I am logged in as "(.*)"$/ do |username|
  login(username, DEFAULT_PASSWORD)
end

When /^I create an user "(.*)"$/ do |username|
  click_link("signup")
  fill_in("user_username", :with => username)
  fill_in("user_email", :with => email_for(username))
  fill_in("user_password", :with => DEFAULT_PASSWORD)
  fill_in("user_password_confirmation", :with => DEFAULT_PASSWORD)
  click_button("commit")
end

When /^I activate my account$/ do
  visit(get_action_url)
end

When /^I login as "(.*)"$/ do |username|
  login(username, DEFAULT_PASSWORD)
end

When /^I login as "(.*)" with "(.*)"$/ do |username, password|
  login(username, password)
end

When /^I log out$/ do
  click_link("logout")
end

When /^I go to forgot password page$/ do
  visit(login_path)
  click_link("forgot_password")
end

When /^I go to change password page$/ do
  click_link("my_account")
  click_link("change_password")
end

When /^I request a password reset for user "(.*)"$/ do |username|
  fill_in("email", :with => email_for(username))
  click_button("commit")
end

When /^I reset my password to "(.*)"$/ do |password|
  visit(get_action_url)
  fill_in("user_password", :with => password)
  fill_in("user_password_confirmation", :with => password)
  click_button("commit")
end

When /^I update my password to "(.*)"$/ do |password|
  click_link("my_account")
  click_link("change_password")
  fill_in("user_old_password", :with => DEFAULT_PASSWORD)
  fill_in("user_password", :with => password)
  fill_in("user_password_confirmation", :with => password)
  click_button("commit")
end

When /^I enter an invalid current password$/ do
  fill_in("user_old_password", :with => "invalid password")
  click_button("commit")
end

Then /^I should receive a notification to activate my user$/ do
  page.should have_content(I18n.t('user.messages.created'));
end

Then /^no user should exist$/ do
  User.count.should be 0
end

Then /^I should receive a success activation message$/ do
  page.should have_content(I18n.t('user.messages.activated'))
end

Then /^the user "(.*)" should be active$/ do |username|
  user = User.find_by_username(username)
  user.active?.should be_true
end

Then /^I should be logged in as "(.*)"$/ do |username|
  page.should have_content("#{I18n.t('user.navbar.logged_as')} #{username}. #{I18n.t('user.navbar.logout')}")
end

Then /^I should not be logged in$/ do
  page.should have_content("#{I18n.t('make')} #{I18n.t('user.navbar.signup')} #{I18n.t('or')} #{I18n.t('user.navbar.login')}")
end

def create_customer(username)
  Factory(:customer, 
         :username => username,
         :password => DEFAULT_PASSWORD,
         :email => email_for(username))
end 

def create_admin(username)
  Factory(:admin, 
         :username => username,
         :password => DEFAULT_PASSWORD,
         :email => email_for(username))
end 

def email_for(username)
  "#{username}@email.com"
end

def get_action_url
  activation_mail = ActionMailer::Base.deliveries.last
  body = activation_mail.body
  match = MAIL_URL.match(body.to_s) 
  match[0]
end

def login(username, password)
  click_link("login")
  fill_in("username", :with => username)
  fill_in("password", :with => password)
  click_button("commit")
end
