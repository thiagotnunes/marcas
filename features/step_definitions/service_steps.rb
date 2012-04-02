Given /^a service "(.*)" with price "(.*)" exists$/ do |name, price|
  FactoryGirl.create(:service, :name => name, :price => price)
end

Given /^a service "(.*)" with price "(.*)" and type "(.*)" exists$/ do |name, price, type|
  FactoryGirl.create(:service, :name => name, :price => price, :order_type_id => OrderType.find_by_name(type).id)
end

When /^I create a service "(.*)" with price "(.*)" and type "(.*)"$/ do |name, price, type|
  click_link("new")
  fill_in("service_name", :with => name)
  fill_in("service_price", :with => price)
  select(type, :from => "service_order_type_id")
  click_button("commit")
end

When /^I edit the service "(.*)" to "(.*)" with price "(.*)" and type "(.*)"$/ do |name, new_name, price, type|
  click_link("edit-#{name.parameterize}")
  fill_in("service_name", :with => new_name)
  fill_in("service_price", :with => price)
  select(type, :from => "service_order_type_id")
  click_button("commit")
end
