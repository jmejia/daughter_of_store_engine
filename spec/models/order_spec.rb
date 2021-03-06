require 'spec_helper'

describe Order do
  let(:new_user){User.new(full_name: "user",
      email: "user@oregonsale.com", password: "omg42", password_confirmation: "omg42") }
  let(:order){Order.new(status: "pending", user_id: 1, total_cost: 3372)}
  let(:li){LineItem.new(product_id: 1, cart_id: nil,
  order_id: 1, quantity: 3, price: 24)}

  describe "generate random" do
    it "generates random thing for different orders" do
      order.created_at = DateTime.now
      a = order.generate_confirmation_code

      new_user = User.new(full_name: "user",
                          email: "user42@oregonsale.com",
                          password: "omg42",
                          password_confirmation: "omg42")
      order2 = Order.new
      order2.user = new_user
      order2.created_at = DateTime.now

      expect(order2.generate_confirmation_code).to_not eq a
    end
  end

  describe "create_visitor_order" do
    let(:cart) { stub(:cart, calculate_total_cost: 42) }
    let(:visitor) { Visitor.new(email: "foo@bar.com") }

    before do
      Order.any_instance.should_receive(:save)
      Order.any_instance.should_receive(:add_line_items).with(cart)
      Order.any_instance.should_receive(:save_with_payment).with("4242")
      Visitor.should_receive(:find_or_create_by_email).with("foo@bar.com").and_return(visitor)
    end

    it "creates a order with a visitor" do
      order = Order.create_visitor_order(cart, "foo@bar.com", "4242")
      expect(order.visitor.email).to eq "foo@bar.com"
    end

    it "creates an order with total cost" do
      order = Order.create_visitor_order(cart, "foo@bar.com", "4242")
      expect(order.total_cost).to eq 42
    end
  end

end
