require 'spec_helper'

describe InvoiceService do
  fixtures :all
  it "Will create an invoice for each store" do
    store = stores(:test)
    order1 = Order.new(total_cost: 80, store_id: store.id)
    order1.created_at = Date.today.ago(1.month)
    order1.save
    order2 = Order.new(total_cost: 120, store_id: store.id)
    order2.created_at = Date.today.ago(1.month)
    order2.save
    orders = store.orders
    start_date = Date.today.ago(1.month).beginning_of_month
    end_date = start_date.end_of_month
    InvoiceService.create(orders, start_date, end_date)
    result = store.invoices.first
    expect(result).to_not be_nil
    expect(result.total_revenue).to eq 200
    expect(result.fee_amount).to eq 10
    expect(result.fee_percentage).to eq 5
    expect(result.start_date).to eq Date.today.ago(1.month).beginning_of_month.to_date
    expect(result.end_date).to eq Date.today.ago(1.month).end_of_month.to_date
    expect(result.status).to eq false
  end
end
