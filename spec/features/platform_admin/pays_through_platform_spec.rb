require 'spec_helper'

describe "Given I am an admin on the platform and I am in the invoices page" do

  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}

  let!(:store) { Store.create!(name: "Oregon Sale",
                               slug: "oregon-sale") }

  let!(:order) { Order.create!(user_id: platform_admin.id,
                               store_id: store.id,
                               total_cost: 1000)}

  let(:invoice) { Invoice.create(store_id: store.id,
                                 total_revenue: 1000,
                                 fee_amount: 50,
                                 start_date: Date.today.ago(1.month).beginning_of_month,
                                 end_date: Date.today.ago(1.month).end_of_month)}

  before do
    order.created_at = Date.today.ago(1.month)
    order.save
    visit login_path
    fill_in("Email", with: platform_admin.email)
    fill_in("password", with: "password")
    click_button("Log in")
    click_link("Current")
  end

  context "when I click the 'generate invoices' button' and I visit a store invoice" do
    before do
      click_button("Generate Invoices")
      invoice = Invoice.last
      visit admin_invoice_path(invoice.id)
    end

    it "shows a 'Pay Invoice' button" do
      expect(page).to have_content("Pay Invoice")
    end
  end

  context "when invoices are generated and I visit a store and click Pay Invoice" do
    before do
      click_button("Generate Invoices")
      click_link("Oregon Sale")
      click_link("Pay Invoice")
    end

    it "redirects to the invoice payment page when I click the 'Pay Invoice' button"  do
      expect(page).to have_button("Submit Payment")
    end

    it "displays a message when I pay an invoice" do
      click_button("Submit Payment")
      expect(page).to have_content("Your invoice has been successfully paid.")
    end
  end
end