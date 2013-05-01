require 'spec_helper'

describe "Given I am an admin on the platform and I am in the invoices page" do
  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}
  let!(:store) { Store.create!(name: "World of Woolcraft",
                               slug: "woolcraft",
                               description: "Wooly")}
  #let!(:product) { Product.create!(name: "Wool",
                                   #description: "Wooly",
                                   #price: 1000,
                                   #store_id: store.id)}
  let!(:order) { Order.create!(user_id: platform_admin.id,
                               store_id: store.id,
                               total_cost: 1000)}

  before do
    order.created_at = Date.today.ago(1.month)
    order.save
    visit login_path
    fill_in("Email", with: platform_admin.email)
    fill_in("password", with: "password")
    click_button("Log in")
    click_link("Current")
  end

  context "when I click the 'generate invoices' button'" do
    before do
      click_button("Generate Invoices")
    end

    it "generates invoices for each store" do
      page.should have_content("Your invoices have been created.")
    end
  end
end
