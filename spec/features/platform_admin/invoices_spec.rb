require 'spec_helper'

describe "Platform Admin has Invoices Dashboard" do

  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}

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
    orders = store.orders
    InvoiceService.create(orders)
  end

  context "as an invalid user" do
    it "throws an error" do
      visit admin_invoices_path
      expect(page).to have_content("Sorry")
    end
  end

  context "as an invalid user" do
    it "throws an error" do
      visit admin_dashboard_path
      expect(page).to have_content("Sorry")
    end
  end

  context "as an invalid user" do
    it "throws an error" do
      visit admin_invoice_path(1)
      expect(page).to have_content("Sorry")
    end
  end

  context "as a valid user" do

    before do
      visit login_path
      fill_in("Email", with: platform_admin.email)
      fill_in("password", with: "password")
      click_button("Log in")
    end

    it "redirects to Admin Dashboard" do
      expect(current_path).to eq admin_dashboard_path
    end

    it "shows a link to view the Invoices" do
      expect(page).to have_link("Invoices", href: admin_invoices_path)
    end

    it "displays the Invoices" do
      click_link("Invoices")
      expect(current_path).to eq admin_invoices_path
    end

    # it "updates an invoice to paid" do
    #   click_link("Invoices")
    #   click_button("Generate Invoices")
    #   save_and_open_page
    #   page.check(store.monthly_invoice.id)
    #   page.should have_content("Successfully changed")
    # end
  end
end
