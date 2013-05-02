module Admin::InvoicesHelper
  def total_orders_amount(orders)
    orders.inject(0){ |sum, order| sum + order.total_cost }
  end

  def total_refunds_amount(orders)
    total = 0

    orders.each do |order|
      total += order.refunds.inject(0){ |sum, refund| sum + refund.amount }
    end
    total
  end

  def total_fees(stores)
    fees = stores.collect do |store|
      store.monthly_fee
    end
    fees.inject(0, :+)
  end
end
