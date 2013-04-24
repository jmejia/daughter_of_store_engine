module Admin::InvoicesHelper

  def fee(orders)
    order_fee = orders.inject(0){ |sum, order| sum + order.total_cost }
    order_fee * 0.05
  end

  def total_fees(stores)
    fees = stores.collect do |store|
      fee(store.orders)
    end
    fees.inject(0, :+)
  end
end
