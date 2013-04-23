class Invoice < ActiveRecord::Base
  attr_accessible :store_id, :start_date, :end_date, :total_revenue,
                  :fee_amount, :fee_percentage, :status

  belongs_to :store

end
