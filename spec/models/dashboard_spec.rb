require 'spec_helper'

describe Dashboard do

  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}

  let!(:store) { Store.create!(name: "Warm Runnings",
                                slug: "warm-runnings",
                                status: "approved") }

  let!(:order) { Order.create!(user_id: platform_admin.id,
                               store_id: store.id,
                               total_cost: 1000)}

  before do
    @product = Product.new(name: "Dog",
                          price: 10000,
                          description: "PITA")
    @product.store_id = store.id
    @product.save
    @dashboard = Dashboard.new(store, platform_admin)
  end


  it "lists active products in a store" do
    expect(@dashboard.products.count).to eq 1
  end

  it "has statuses" do
    expect(@dashboard.statuses.count).to eq 5
  end
end