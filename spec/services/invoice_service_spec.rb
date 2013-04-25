require 'spec_helper'

describe InvoiceService do
  fixtures :all
  it "Will create an invoice for each store" do
    store = stores(:test)
    order1 = Order.new(total_cost: 80, store_id: store.id)
    order1.created_at = Date.new(2010,10,10)
    order1.save
    order2 = Order.new(total_cost: 120, store_id: store.id)
    order2.created_at = Date.new(2010,10,11)
    order2.save
    orders = store.orders
    InvoiceService.create(orders)
    result = store.invoices.first
    expect(result).to_not be_nil
    expect(result.total_revenue).to eq 200
    expect(result.fee_amount).to eq 10
    expect(result.fee_percentage).to eq 5
    expect(result.start_date).to eq Date.new(2010,10,10)
    expect(result.end_date).to eq Date.new(2010,10,11)
    expect(result.status).to eq "outstanding"
  end
end
