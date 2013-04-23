class Invoice < ActiveRecord::Base
  attr_accessible :store_id, :start_date, :end_date, :total_revenue,
                  :fee_amount, :fee_percentage, :status

  validates_presence_of :store_id, :start_date, :end_date, :total_revenue,
                  :fee_amount

  belongs_to :store

end
