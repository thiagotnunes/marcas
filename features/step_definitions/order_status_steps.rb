Given /^an order status "(.*)" exists$/ do |status|
  Factory(:order_status, :status => status)
end

When /^I create a order status "(.*)"$/ do |status|
  click_link("new")
  fill_in("order_status_status", :with => status)
  fill_in("order_status_color", :with => "#FF0000")
  click_button("commit")
end

When /^I edit the order status "(.*)" to "(.*)"$/ do |status, new_status|
  click_link("edit-#{status.parameterize}")
  fill_in("order_status_status", :with => new_status)
  click_button("commit")
end
