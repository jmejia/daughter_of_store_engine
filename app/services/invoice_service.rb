class InvoiceService
  def self.create(payments)
    payment_dates = payments.collect(&:created_at)
    start_date    = payment_dates.min
    end_date      = payment_dates.max

    payment_fee = payments.inject(0){ |sum, payment| sum + payment.total_cost }
    fee_amount  = payment_fee * 0.05
    Invoice.create!(total_revenue: payment_fee,
                    store_id:      payments.first.store.id,
                    start_date:    start_date,
                    end_date:      end_date,
                    fee_amount:    fee_amount)
  end
end
