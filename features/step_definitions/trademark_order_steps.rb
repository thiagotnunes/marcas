Given /^the following trademark orders exist$/ do |table|
  table.hashes.each do |hash|
    user = User.find_by_username(hash["user"])
    service = Service.find_by_name(hash["service"])
    order_status = OrderStatus.find_by_status(hash["order_status"])

    new_hash = hash.reject { |key| key == "user" || key == "service" || key == "order_status" }

    trademark = FactoryGirl.build(:trademark_order, new_hash)
    order = FactoryGirl.build(:order, :user => user, :service => service, :order_status => order_status)

    trademark.purchase = order
    trademark.save!
  end
end

When /^I go to the new trademark order page$/ do
  click_on("new_trademark_order")
end

When /^I create an order trademark with the following attributes$/ do |table|
  table.hashes.each do |hash|
    @last_created_order = create_order_with(hash)

    fill_in("trademark_order_name", :with => hash[:name])
    select(hash[:segment], :from => "trademark_order_segment")
    select(hash[:subsegment], :from => "trademark_order_subsegment")
    fill_in("trademark_order_observations", :with => hash[:observations])
    select(hash[:service], :from => "purchase_service_id")
    click_button("commit")
  end
end

When /^I alter the status of "(.*)" to "(.*)"$/ do |name, status|
  click_on("edit-#{name.parameterize}")
  select(status, :from => "order_order_status_id")
  click_button("commit")
end

When /^I pay for it$/ do
  click_on("pay")
end

Then /^I should see a payment message$/ do
  page.should have_content(I18n.t('trademark_orders.flash.create.alert.title'))
  page.should have_content(I18n.t('trademark_orders.flash.create.alert.message'))
end

Then /^an order to pagseguro should have been created$/ do
  pagseguro = YAML.load_file(File.join(Rails.root, "tmp", "pagseguro-test.yml"))
  pagseguro["1"]["item_quant_1"].should == "1"
  pagseguro["1"]["moeda"].should == "BRL"
  pagseguro["1"]["item_descr_1"].should == @last_created_order.purchase.service.name
  pagseguro["1"]["item_valor_1"].should == "%.0f" % (@last_created_order.purchase.service.price * 100)
end

def create_order_with(hash)
  order = Order.new
  order.service = Service.find_by_name(hash[:service])

  trademark = TrademarkOrder.new
  trademark.name = hash[:name]
  trademark.segment = hash[:segment]
  trademark.subsegment = hash[:subsegment]
  trademark.observations = hash[:observations]
  trademark.purchase = order

  trademark
end
