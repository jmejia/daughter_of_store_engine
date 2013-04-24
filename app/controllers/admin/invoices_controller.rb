class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
    @stores = Store.all
  end

  def show
  end

  def generate_invoices
    @stores = Store.all

    @stores.each do |store|
      orders = store.orders
      InvoiceService.create(orders)
    end

    redirect_to admin_invoices_path, :notice => "Your invoices have been created."
  end
end