class ChangeStatusToBooleanInInvoices < ActiveRecord::Migration
  def up
    remove_column :invoices, :status
    add_column :invoices, :status, :boolean, :default => false
  end

  def down
    remove_column :invoices, :status
    add_column :invoices, :status, :string, :default => "outstanding"
  end
end
