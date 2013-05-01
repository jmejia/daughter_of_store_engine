class GlobalFee < ActiveRecord::Base
  attr_accessible :amount

  def percentage
    self.amount / 100.0
  end
end
