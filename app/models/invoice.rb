class Invoice < ActiveRecord::Base
  attr_accessible :store_id, :start_date, :end_date, :total_revenue,
                  :fee_amount, :fee_percentage, :status

  validates_presence_of :store_id, :start_date, :end_date, :total_revenue,
                  :fee_amount

  belongs_to :store
  has_many :orders

  def self.monthly_invoices?(start_date)
    end_date = start_date.end_of_month
    invoice = Invoice.where(:start_date => start_date..end_date).first
    if invoice
      true
    end
  end

  def self.outstanding_balance(start_date)
    monthly_invoices = Invoice.where(created_at: start_date.beginning_of_day..start_date.end_of_month)
    if monthly_invoices.empty?
      Order.total_monthly_fees(start_date - 1.month)
    else
      monthly_invoices = monthly_invoices.where(status: false)
      order_fee = monthly_invoices.inject(0){ |sum, invoice| sum + invoice.fee_amount }
      order_fee
    end
  end
end
