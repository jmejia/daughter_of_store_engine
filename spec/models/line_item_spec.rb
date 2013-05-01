require 'spec_helper'

describe LineItem do
  it "total" do
    li = LineItem.new
    li.price = 3
    li.quantity = 10

    expect(li.total).to eq 30
  end

  it "hist_total" do
    li = LineItem.new
    li.price = 3
    li.quantity = 10

    expect(li.historical_total).to eq 30
  end

  it "decreases the quantity" do
    product = stub(:id => 1)
    cart = stub(:id => 1)
    order = stub(:id => 1)
    li = LineItem.create(product_id: product.id,
                         cart_id: cart.id,
                         quantity: 12,
                         order_id: order.id,
                         price: 1000)
    li.decrease_quantity
    expect(li.quantity).to eq 11
  end

  it "increases the quantity" do
    product = stub(:id => 1)
    cart = stub(:id => 1)
    order = stub(:id => 1)
    li = LineItem.create(product_id: product.id,
                         cart_id: cart.id,
                         quantity: 12,
                         order_id: order.id,
                         price: 1000)
    li.increase_quantity
    expect(li.quantity).to eq 13
  end
end