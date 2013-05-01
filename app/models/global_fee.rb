class GlobalFee < ActiveRecord::Base
  attr_accessible :amount

  def percentage
    self.amount / 100.to_f
  end
end
