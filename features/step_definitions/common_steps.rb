Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should see "(.*)"$/ do |query|
  page.should have_content(query)
end

Then /^I should not see "(.*)"$/ do |query|
  page.should_not have_content(query)
end
