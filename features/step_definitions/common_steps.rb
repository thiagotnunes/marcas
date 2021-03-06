Given /^I am on the home page$/ do
  visit(root_url)
end

Given /^no (.*) exists$/ do |name|
  constant_for(name).destroy_all
end

When /^I go to the list of (.*)$/ do |name|
  click_link(name.gsub(' ', '_'))
end

When /^I cancel$/ do
  click_on("cancel")
end

When /^I click on "(.*)"$/ do |element|
  click_on(element)
end

When /^I delete "(.*)"$/ do |id|
  click_link("destroy-#{id.parameterize}")
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

Then /^I should receive an error$/ do
  find("#error").should be_true
end

Then /^I should be on the home page$/ do
  current_url == root_url
end

Then /^I should not have received any email$/ do
  ActionMailer::Base.deliveries.empty?.should be_true
end

Then /^I should not see any (.*)$/ do |name|
  page.should have_content(I18n.t("#{name.gsub(' ', '_').pluralize}.index.empty"))
end

def constant_for(element)
  element.gsub(' ', '_').camelize.constantize
end
