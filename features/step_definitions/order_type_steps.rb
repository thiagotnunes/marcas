Given /^no order type exists$/ do
  OrderType.destroy_all
end

Given /^an order type "(.*)" exists$/ do |name|
  Factory(:order_type, :name => name)
end

When /^I go to the list of order types$/ do
  click_link("order_types")
end

When /^I create a order type "(.*)"$/ do |name|
  click_link("new")
  fill_in("order_type_name", :with => name)
  click_button("commit")
end

When /^I edit the order type "(.*)" to "(.*)"$/ do |name, new_name|
  click_link("edit-#{name.parameterize}")
  fill_in("order_type_name", :with => new_name)
  click_button("commit")
end

Then /^I should not see any order types/ do
  page.should have_content(I18n.t('order_types.index.empty'))
end

