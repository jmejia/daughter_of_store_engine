require 'spec_helper'

describe "Given I am an admin on the platform and I am in the invoices page" do
  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}

  before do
    visit login_path
    fill_in("Email", with: platform_admin.email)
    fill_in("password", with: "password")
    click_button("Log in")
    visit admin_invoices_path
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
