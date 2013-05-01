require 'spec_helper'

describe Admin::InvoicesHelper do
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

  # it "returns the total fees associated with the store" do
  #   expect(invoice.total_fees(store)).to eq 50
  # end
end