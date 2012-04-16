require 'spec_helper'

describe PagSeguro::CheckoutStrategyFactory do

  subject { PagSeguro::CheckoutStrategyFactory.new }

  it "should return fake checkout strategy for developer environment" do
    subject.strategy_for("developer").class.should == PagSeguro::FakeCheckoutStrategy
  end

  it "should return fake checkout strategy for test environment" do
    subject.strategy_for("test").class.should == PagSeguro::FakeCheckoutStrategy
  end

  it "should return checkout strategy for production environment" do
    subject.strategy_for("production").class.should == PagSeguro::CheckoutStrategy
  end
end
