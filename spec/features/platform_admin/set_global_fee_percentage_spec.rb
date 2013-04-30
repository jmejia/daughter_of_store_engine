require 'spec_helper'

describe "Platform Admin sets global fee percentage" do

    let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                         email: "admin@example.com",
                                         password: "password",
                                         platform_administrator: true) }

    let!(:store) { Store.create!(name: "test store", slug: "test-store") }

    let!(:order1) { Order.create!(status: "pending", user_id: 1, total_cost: 3372, store_id: store.id) }
    let!(:order2) { Order.create!(status: "pending", user_id: 4, total_cost: 7375, store_id: store.id) }

    before do
      visit login_path
      fill_in("Email", with: platform_admin.email)
      fill_in("password", with: "password")
      click_button("Log in")
      order1.update_attribute(:created_at, "2013-03-01 00:00:00")
      order2.update_attribute(:created_at, "2013-03-01 00:00:00")
    end

    it "changes the global fee percentage" do
      visit admin_dashboard_path
      expect(page).to have_content("Set Global Fee")
    end

    it "displays the correct fee amount for orders that have been placed"
end
