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
    Invoice.where(:start_date => start_date..end_date).first
  end

  def self.total_balance(start_date)
    monthly_invoices = Invoice.where(start_date: start_date.beginning_of_day..start_date.end_of_month.end_of_day)
    monthly_invoices.inject(0){ |sum, invoice| sum + invoice.fee_amount }
  end

  def self.outstanding_balance(start_date)
    monthly_invoices = Invoice.where(start_date: start_date.beginning_of_day..start_date.end_of_month.end_of_day)

    if monthly_invoices.empty?
       end_date = start_date.end_of_month
       stores = Store.all
       store_fees = []
       stores.each do |store|
        orders = store.orders.where(created_at: start_date..end_date)
        total_costs = orders.inject(0){|sum, order| sum + (order.total_cost || 0)}
        store_fees << (total_costs * GlobalFee.first.percentage).to_i
      end
      store_fees.inject(0,:+)
    else
      monthly_invoices = monthly_invoices.where(status: false)
      order_fee = monthly_invoices.inject(0){ |sum, invoice| sum + invoice.fee_amount }
      order_fee
    end
  end
end
