require "spec_helper"

describe UserMailer do
  describe "order_confirmation" do

    let(:user) { User.create(full_name: "JoshMejia",
                             email: "user@epicsale.com",
                             password: "password") }
    let(:order) { Order.create(confirmation: "AAAAAA") }
    let(:mail) { UserMailer.order_confirmation(user, order) }

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["user@epicsale.com"])
      mail.from.should eq(["no-reply@epicsale.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("JoshMejia")
    end
  end

  # describe "monthly invoice" do

  #   let(:user) { User.create(full_name: "JoshMejia",
  #                            email: "user@epicsale.com",
  #                            password: "password") }
  #   let(:store) { Store.create(name: "Warm Runnings",
  #                               slug: "warm-runnings",
  #                               status: "approved") }
  #   let(:role) { Role.create(title: admin) }
  #   let(:user_store) { UserStore.create(user_id: user.id,
  #                                       store_id: store.id,
  #                                       role_id: role.id) }
  #   let!(:order) { Order.create!(user_id: user.id,
  #                              store_id: store.id,
  #                              total_cost: 1000)}
  #   let(:invoice) { Invoice.create!(store_id: store.id,
  #                                  total_revenue: 1000,
  #                                  fee_amount: 50,
  #                                  start_date: Date.today.ago(1.month).beginning_of_month,
  #                                  end_date: Date.today.ago(1.month).end_of_month)}
  #   let(:mail) { UserMailer.monthly_invoice(store, user, Date.today.ago(1.month).beginning_of_month) }

  #   it "renders the headers" do
  #     mail.subject.should eq("Monthly invoice")
  #     mail.to.should eq(["user@epicsale.com"])
  #     mail.from.should eq(["no-reply@epicsale.com"])
  #   end

  #   it "renders the body" do
  #     mail.body.encoded.should match("JoshMejia")
  #   end
  # end

end
