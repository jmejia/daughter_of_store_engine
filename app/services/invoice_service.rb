class InvoiceService
  def self.create(orders)
    order_dates = orders.collect(&:created_at)
    start_date  = order_dates.min
    end_date    = order_dates.max

    order_fee = orders.inject(0){ |sum, order| sum + order.total_cost }
    fee_amount = order_fee * 0.05
    Invoice.create!(total_revenue: order_fee,
                    store_id:      orders.first.store_id,
                    start_date:    start_date,
                    end_date:      end_date,
                    fee_amount:    fee_amount)
  end
end
