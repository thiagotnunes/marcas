When /^I go to the list of customers$/ do
  visit(users_path)
end

Then /^I should not see any customers$/ do
  page.should have_content(I18n.t('user.messages.customer.empty'))
end

Then /^I should see an activated user$/ do 
  page.should have_content(I18n.t('user.messages.active'))
end

Then /^I should see a unactive user$/ do 
  page.should have_content(I18n.t('user.messages.unactive'))
end
