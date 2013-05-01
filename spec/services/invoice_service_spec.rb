require 'spec_helper'

describe InvoiceService do
  fixtures :all
  it "Will create an invoice for each store" do
    store = Store.create(name: "Warm Runnings", slug: "warm-runnings", status: "approved")
    payment1 = Payment.new(80, store, Date.today.ago(1.month))
    payment2 = Payment.new(120, store, Date.today.ago(1.month))
    global_fee = GlobalFee.create(amount: 10)
    InvoiceService.create([payment1, payment2], global_fee)
    result = store.invoices.first
    expect(result).to_not be_nil
    expect(result.total_revenue).to eq 200
    expect(result.fee_amount).to eq 20
    expect(result.fee_percentage).to eq 10
    expect(result.start_date).to eq Date.today.ago(1.month).beginning_of_month.to_date
    expect(result.end_date).to eq Date.today.ago(1.month).end_of_month.to_date
    expect(result.status).to eq false
  end
end
