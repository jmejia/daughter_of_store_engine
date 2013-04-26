class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
    @stores = Store.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @orders = @invoice.store.orders
  end

  def update
    invoice = Invoice.find(params[:id])

    if invoice.update_attributes(params[:invoice])
      #  render :json => {:status => "success", :notice => "Successfully changed status of invoice."}
      flash.now[:notice] = "Successfully changed status of invoice."
    else
      flash.now[:error] = "Unable to mark invoice as paid"
    end
  end

  def pay
    @invoice = Invoice.find(params[:id])
    @fee     = params[:fee]
  end

  def submit_payment
    invoice = Invoice.find(params[:id])

    if invoice.update_attributes(params[:invoice])
      redirect_to admin_invoice_path(invoice), :notice => "Your invoice has been successfully paid."
    else
      render :pay, :notice => "We were unable to process your payment."
    end
  end

  def generate_invoices
    @stores = Store.all

    @stores.each do |store|
      orders = store.orders
      InvoiceService.create(orders)
      UserMailer.delay.monthly_invoice(store)
    end

    redirect_to admin_invoices_path, :notice => "Your invoices have been created."
  end
end
