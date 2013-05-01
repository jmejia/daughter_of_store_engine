class Refund < ActiveRecord::Base
  belongs_to :order
  attr_accessible :amount
  attr_accessible :order_id

  def to_payment
    Payment.new(-self.total_cost, self.order.store, self.created_at)
  end
end