class InvoiceService
  def self.create(payments, global_fee)
    payment_date = payments[0].created_at
    start_date   = payment_date.beginning_of_month
    end_date     = payment_date.end_of_month

    total_revenue = total_revenue(payments)
    fee_amount  = calculate_fee(total_revenue, global_fee)

    invoice = Invoice.create!(
                    total_revenue:  total_revenue,
                    store_id:       payments.first.store.id,
                    start_date:     start_date,
                    end_date:       end_date,
                    fee_percentage: global_fee.amount,
                    fee_amount:     fee_amount)
  end

  def self.total_revenue(payments)
    payments.inject(0){ |sum, payment| sum + (payment.total_cost || 0) }
  end

  def self.calculate_fee(total_revenue, global_fee)
    total_revenue * global_fee.percentage
  end
end
