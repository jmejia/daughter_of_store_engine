class RefundService
  def self.create(order, amount = nil)
    total_cost = amount || order.total_cost
    Refund.create(amount: total_cost, order_id: order.id)
  end
end