Given /^an order type "(.*)" exists$/ do |name|
  Factory(:order_type, :name => name)
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
