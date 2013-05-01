class Invoice < ActiveRecord::Base
  attr_accessible :store_id, :start_date, :end_date, :total_revenue,
                  :fee_amount, :fee_percentage, :status

  validates_presence_of :store_id, :start_date, :end_date, :total_revenue,
                  :fee_amount

  belongs_to :store
  has_many :orders

  def self.find_unpaid_for(start_date)
    end_date = start_date.end_of_month
    Invoice.where(:start_date => start_date..end_date, :status => false)
  end

  def self.monthly_invoices?(start_date)
    end_date = start_date.end_of_month
    invoice = Invoice.where(:start_date => start_date..end_date).first
    if invoice
      true
    end
  end

  def self.total_balance(start_date)
    monthly_invoices = Invoice.where(start_date: start_date.beginning_of_day..start_date.end_of_month.end_of_day)
    monthly_invoices.inject(0){ |sum, invoice| sum + invoice.fee_amount }
  end

  def self.outstanding_balance(start_date)
    monthly_invoices = Invoice.where(start_date: start_date.beginning_of_day..start_date.end_of_month.end_of_day)

    if monthly_invoices.empty?
       Order.total_monthly_fees(start_date)
      # @stores = Store.all
      # end_date = start_date.end_of_month
      # global_fee = GlobalFee.first
      # payments = @stores.map do |store|
      #   store.payments(start_date..end_date)
      # end
      # payment_fee = payments.inject(0){ |sum, payment| sum + (payment.total_cost || 0) }
      # fee_amount  = payment_fee * global_fee.percentage
    else
      monthly_invoices = monthly_invoices.where(status: false)
      order_fee = monthly_invoices.inject(0){ |sum, invoice| sum + invoice.fee_amount }
      order_fee
    end
  end
end
