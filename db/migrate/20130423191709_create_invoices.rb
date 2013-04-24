class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :store
      t.date :start_date
      t.date :end_date
      t.integer :total_revenue
      t.integer :fee_amount
      t.integer :fee_percentage, :default => 5
      t.string :status, :default => "outstanding"

      t.timestamps
    end
    add_index :invoices, :store_id
  end
end
