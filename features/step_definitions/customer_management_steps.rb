When /^I go to the list of customers$/ do
  visit(users_path)
end

When /^I delete "(.*)"$/ do |username|
  click_link("destroy-#{username}")
end

Then /^I should not see any customers$/ do
  page.should have_content(I18n.t('user.messages.customer.empty'))
end
