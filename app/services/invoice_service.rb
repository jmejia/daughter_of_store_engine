class InvoiceService
  def self.create(*orders)
    total_cost  = 0
    order_dates = orders.collect(&:created_at)
    start_date  = order_dates.min
    end_date    = order_dates.max

    orders.each do |order|
      total_cost += order.total_cost
    end
    fee_amount = total_cost * 0.05
    Invoice.create!(total_revenue: total_cost,
                    store_id:      orders.first.store_id,
                    start_date:    start_date,
                    end_date:      end_date,
                    fee_amount:    fee_amount)
  end
end