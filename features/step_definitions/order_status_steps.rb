Given /^an order status "(.*)" exists$/ do |status|
  FactoryGirl.create(:order_status, :status => status)
end

Given /^a first order status "(.*)" exists$/ do |status|
  FactoryGirl.create(:order_status, :status => status, :lifecycle => OrderStatus::LIFECYCLES[:first])
end

When /^I create a order status "(.*)", activated "(.*)"$/ do |status, lifecycle|
  click_link("new")
  fill_in("order_status_status", :with => status)
  select("Parado", :from => "order_status_color")
  select(lifecycle, :from => "order_status_lifecycle")
  click_button("commit")
end

When /^I edit the order status "(.*)" to "(.*)" with lifecycle "(.*)"$/ do |status, new_status, new_lifecycle|
  click_link("edit-#{status.parameterize}")
  fill_in("order_status_status", :with => new_status)
  select(new_lifecycle, :from => "order_status_lifecycle")
  click_button("commit")
end
