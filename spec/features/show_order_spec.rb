require 'spec_helper'

describe "Shows an order" do
  let!(:user) { User.create!(full_name: "Mr. Admin",
                             email: "admin@example.com",
                             password: "password",
                             platform_administrator: true)}

  let!(:store) { Store.create!(name: "Warm Runnings",
                               slug: "warm-runnings",
                               status: "approved") }

  let!(:order) { Order.create!(user_id: user.id,
                               store_id: store.id,
                               total_cost: 1000)}

  it "shows the order" do
    visit login_path
    fill_in("Email", with: user.email)
    fill_in("password", with: "password")
    click_button("Log in")
    visit order_path(order.id)
    page.should have_content "$10.00"
  end

  it "updates an order" do
    pending
    visit login_path
    fill_in("Email", with: user.email)
    fill_in("password", with: "password")
    click_button("Log in")
    visit order_path(order.id)
    click_link("Paid")
    page.should have_content "Paid"
  end
end