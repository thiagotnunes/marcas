Given /^I am on the home page$/ do
  visit(root_url)
end

Given /^I am on the forgot password page$/ do
  visit(new_password_reset_url)
end

When /^I cancel$/ do
  click_on("cancel")
end

When /^I click on "(.*)"$/ do |element|
 click_link(element) 
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should see "(.*)"$/ do |query|
  page.should have_content(query)
end

Then /^I should not see "(.*)"$/ do |query|
  page.should_not have_content(query)
end

Then /^I should be on the home page$/ do
  current_url == root_url
end

Then /^I should not have received any email$/ do
  ActionMailer::Base.deliveries.empty?.should be_true
end
