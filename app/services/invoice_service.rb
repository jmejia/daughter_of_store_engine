class InvoiceService
  def self.create(orders, start_date, end_date)
    order_fee = orders.inject(0){ |sum, order| sum + (order.total_cost || 0) }
    fee_amount = order_fee * 0.05

    invoice = Invoice.create(total_revenue:  order_fee,
                    store_id:      orders.first.store_id,
                    start_date:    start_date,
                    end_date:      end_date,
                    fee_amount:    fee_amount)
  end
end
