class InvoiceService
  def self.create(orders)
    start_date = DateTime.now.ago(1.month).beginning_of_month
    end_date = DateTime.now.ago(1.month).end_of_month

    # orders.collect do |order|
    #     if order.created_at.to_i >= start_date.to_i && order.created_at.to_i <= end_date.to_i
    #     end
    # end


    #order_dates = orders.collect(&:created_at)
        order_fee = orders.inject(0){ |sum, order| sum + (order.total_cost || 0) }
        fee_amount = order_fee * 0.05

        invoice = Invoice.create(total_revenue:  order_fee,
                        store_id:      orders.first.store_id,
                        start_date:    start_date,
                        end_date:      end_date,
                        fee_amount:    fee_amount)
  end
end
