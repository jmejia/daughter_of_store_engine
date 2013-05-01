class InvoiceService
  def self.create(payments, global_fee)
    payment_date = payments[0].created_at
    start_date   = payment_date.beginning_of_month
    end_date     = payment_date.end_of_month

    payment_fee = payments.inject(0){ |sum, payment| sum + (payment.total_cost || 0) }
    fee_amount  = payment_fee * global_fee.amount/100.to_f
    invoice = Invoice.create!(total_revenue: payment_fee,
                    store_id:       payments.first.store.id,
                    start_date:     start_date,
                    end_date:       end_date,
                    fee_percentage: global_fee.amount,
                    fee_amount:     fee_amount)
  end
end
