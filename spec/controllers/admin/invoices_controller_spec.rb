require 'spec_helper'

describe Admin::InvoicesController do

  let!(:store) { Store.create!(name: "Warm Runnings",
                                slug: "warm-runnings",
                                status: "approved") }

  before do
    order1 = Order.new(total_cost: 80, store_id: store.id)
    order1.created_at = Date.new(2010,10,10)
    order1.save
    order2 = Order.new(total_cost: 120, store_id: store.id)
    order2.created_at = Date.new(2010,10,11)
    order2.save
    @orders = store.orders
    # invoice = InvoiceService.create(orders)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
  end

  let!(:invoice) { InvoiceService.create(@orders) }

  def valid_attributes
    {store_id: store.id,
     start_date: Time.now,
     end_date: Time.now,
     total_revenue: 10000,
     fee_amount: 500
    }
  end

  describe "PUT update" do
    before do
      @ability.can :update, Invoice
      invoice.stub(:save).and_return(true)
    end

    # it "assigns the requested invoice as @invoice" do
    #   put :update, {:id => invoice.to_param, :invoice => valid_attributes}
    #   assigns(:invoice).should eq(invoice)
    # end
  end
end