require 'spec_helper'

describe "Platform Admin has Invoices Dashboard" do

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

  let!(:invoice) { Invoice.create!(store_id: store.id,
                                   total_revenue: 1000,
                                   fee_amount: 50,
                                   start_date: Date.today.ago(1.month).beginning_of_month,
                                   end_date: Date.today.ago(1.month).end_of_month)}

  before do
    order.created_at = Date.today.ago(1.month)
    order.save
  end

  context "as an invalid user" do
    it "throws an error" do
      visit monthly_admin_invoices_path(year: Date.today.strftime("%Y"),
                                        month: Date.today.strftime("%m"))
      expect(page).to have_content("Sorry")
    end

    it "throws an error" do
      visit monthly_admin_invoices_path(year: Date.today.strftime("%Y"),
                                        month: Date.today.strftime("%m"))
      expect(page).to have_content("Sorry")
    end

    it "throws an error" do
      visit admin_invoice_path(invoice.id)
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
      expect(page).to have_link("Current", href: monthly_admin_invoices_path(year: Date.today.strftime("%Y"),
                                                                            month: Date.today.strftime("%m")))
    end

    it "displays the Invoices" do
      click_link("Current")
      expect(current_path).to eq monthly_admin_invoices_path(year: Date.today.strftime("%Y"),
                                                             month: Date.today.strftime("%m"))
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
