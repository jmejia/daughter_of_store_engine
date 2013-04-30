require 'spec_helper'

describe InvoiceService do
  fixtures :all
  it "Will create an invoice for each store" do
    store = stores(:test)
    payment1 = Payment.new(80, store, Date.new(2010,10,10))
    payment2 = Payment.new(120, store, Date.new(2010,10,11))
    InvoiceService.create([payment1, payment2])
    result = store.invoices.first
    expect(result).to_not be_nil
    expect(result.total_revenue).to eq 200
    expect(result.fee_amount).to eq 10
    expect(result.fee_percentage).to eq 5
    expect(result.start_date).to eq Date.new(2010,10,10)
    expect(result.end_date).to eq Date.new(2010,10,11)
    expect(result.status).to eq false
  end
end
