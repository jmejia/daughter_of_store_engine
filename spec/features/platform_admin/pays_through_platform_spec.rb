require 'spec_helper'

describe "Given I am an admin on the platform and I am in the invoices page" do

  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}

  let!(:store) { Store.create!(name: "Oregon Sale",
                               slug: "oregon-sale") }

  let!(:order) { Order.create!(store_id: store.id,
                               total_cost: 1000) }

  let!(:invoice) { Invoice.create!(store_id: store.id,
                                   start_date: Date.new(2010,01,01),
                                   end_date: Date.new(2010,05,01),
                                   total_revenue: 200,
                                   fee_amount: 10,
                                   status: false) }

  before do
    visit login_path
    fill_in("Email", with: platform_admin.email)
    fill_in("password", with: "password")
    click_button("Log in")
    visit admin_invoices_path
  end

  context "when I click the 'generate invoices' button' and I visit a store invoice" do
    before do
      InvoiceService.should_receive(:create)
      click_button("Generate Invoices")
      visit admin_invoice_path(1)
    end

    it "shows a 'Pay Invoice' button" do
      expect(page).to have_content("Pay Invoice")
    end
  end

  context "when invoices are generated and I visit a store" do
    before(:each) do
      InvoiceService.should_receive(:create)
      click_button("Generate Invoices")
      click_link("Oregon Sale")
    end

    context "when I click the 'Pay Invoice' button" do
      before(:each) do
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
end