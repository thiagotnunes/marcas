Given /^an order status "(.*)" exists$/ do |status|
  FactoryGirl.create(:order_status, :status => status)
end

Given /^a first order status "(.*)" exists$/ do |status|
  FactoryGirl.create(:order_status, :status => status, :first_status => 1)
end

When /^I create a order status "(.*)"$/ do |status|
  click_link("new")
  fill_in("order_status_status", :with => status)
  select("Parado", :from => "order_status_color")
  click_button("commit")
end

When /^I edit the order status "(.*)" to "(.*)"$/ do |status, new_status|
  click_link("edit-#{status.parameterize}")
  fill_in("order_status_status", :with => new_status)
  click_button("commit")
end
