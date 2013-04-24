class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
  end

  def generate_invoices
    InvoiceService.create
    redirect_to admin_invoices_path, :notice => "Your invoices have been created."
  end
end