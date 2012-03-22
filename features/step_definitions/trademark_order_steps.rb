Given /^the following trademark orders exist$/ do |table|
  table.hashes.each do |hash|
    user = User.find_by_username(hash["user"])
    new_hash = hash.reject { |key| key == "user" }
    new_hash["user_id"] = user.id
    Factory(:trademark_order, new_hash)
  end
end

When /^I go to the new trademark order page$/ do
  click_on("new_trademark_order")
end

When /^I create an order trademark with the following attributes$/ do |table|
  table.hashes.each do |hash|
    fill_in("trademark_order_name", :with => hash[:name])
    select(hash[:segment], :from => "trademark_order_segment")
    select(hash[:subsegment], :from => "trademark_order_subsegment")
    fill_in("trademark_order_observations", :with => hash[:observations])
    click_button("commit")
  end
end
