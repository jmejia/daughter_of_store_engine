require 'spec_helper'

describe GlobalFee do
  it "converts the global fee to a percentage" do
    globalfee = GlobalFee.create(amount: 5)
    expect(globalfee.percentage).to eq 0.05
  end
end
