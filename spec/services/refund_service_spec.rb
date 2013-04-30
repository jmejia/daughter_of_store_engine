require 'spec_helper'

describe RefundService do
  fixtures :all
  it "will create a refund for the specified" do
    order = orders(:test)
    RefundService.create(order)
    result = order.refunds.first
    expect(result).to_not be_nil
    expect(result.amount).to eq(order.total_cost)
  end

  it "will create a refund with the specified amount" do
    order  = orders(:test)
    amount = 10000
    RefundService.create(order, amount)
    result = order.refunds.first
    expect(result.amount).to eq(amount)
  end
end