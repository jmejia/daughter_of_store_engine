require 'spec_helper'

describe "Platform Admin has Invoices Dashboard" do

  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}

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
    click_link(href: admin_invoices_path)
    expect(current_path).to eq admin_invoices_path
  end

  it "" do

  end




end
