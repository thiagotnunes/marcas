When /^I go to the list of customers$/ do
  visit(users_path)
end

Then /^I should see "(.*)"$/ do |query|
  page.should have_content(query)
end

Then /^I should not see "(.*)"$/ do |query|
  page.should_not have_content(query)
end
