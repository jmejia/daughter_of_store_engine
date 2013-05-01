class Refund < ActiveRecord::Base
  belongs_to :order
  attr_accessible :amount
  attr_accessible :order_id

  def to_payment
    Payment.new(self.amount * -1, self.order.store, self.created_at)
  end
end