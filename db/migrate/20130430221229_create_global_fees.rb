class CreateGlobalFees < ActiveRecord::Migration
  def change
    create_table :global_fees do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
