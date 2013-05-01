class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds do |t|
      t.integer :amount
      t.references :order

      t.timestamps
    end
    add_index :refunds, :order_id
  end
end
