Given /^the following trademark orders exist$/ do |table|
  table.hashes.each do |hash|
    user = User.find_by_username(hash["user"])
    service = Service.find_by_name(hash["service"])
    order_status = OrderStatus.find_by_status(hash["order_status"])

    new_hash = hash.reject { |key| key == "user" || key == "service" || key == "order_status" }
    new_hash["user_id"] = user.id
    new_hash["service_id"] = service.id
    new_hash["order_status_id"] = order_status.id

    FactoryGirl.create(:trademark_order, new_hash)
  end
end

When /^I go to the new trademark order page$/ do
  click_on("trademarks")
  click_on("new_trademark_order")
end

When /^I create an order trademark with the following attributes$/ do |table|
  table.hashes.each do |hash|
    fill_in("trademark_order_name", :with => hash[:name])
    select(hash[:segment], :from => "trademark_order_segment")
    select(hash[:subsegment], :from => "trademark_order_subsegment")
    fill_in("trademark_order_observations", :with => hash[:observations])
    select(hash[:service], :from => "trademark_order_service_id")
    click_button("commit")
  end
end

When /^I alter the status of "(.*)" to "(.*)"$/ do |name, status|
  click_on("edit-#{name.parameterize}")
  select(status, :from => "trademark_order_order_status_id")
  click_button("commit")
end
