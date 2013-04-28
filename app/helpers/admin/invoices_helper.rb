module Admin::InvoicesHelper

  def total_order_amount(orders)
    orders.inject(0){ |sum, order| sum + order.total_cost }
  end

  def total_fees(stores)
    fees = stores.collect do |store|
      store.monthly_fee
    end
    fees.inject(0, :+)
  end
end
