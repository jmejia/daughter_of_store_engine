class Admin::InvoicesController < ApplicationController
  before_filter :require_admin,
                except: [:show, :store_invoices, :pay, :submit_payment]

  def index
    @invoices = Invoice.all
    @url_date = Date.new(params[:year].to_i, params[:month].to_i)
    @previous_month_start_date = @url_date - 1.month
    @total_fees = Order.total_monthly_fees(@previous_month_start_date)
    @outstanding_balance = Invoice.outstanding_balance(@previous_month_start_date)
    @monthly_invoices = Invoice.monthly_invoices?(@previous_month_start_date)
    @stores = Store.all
    @existing_invoices = Invoice.monthly_invoices?(@previous_month_start_date)
  end

  def store_invoices
    @store    = Store.find(params[:id])
    @invoices = @store.invoices
  end

  def show
    @invoice    = Invoice.find(params[:id])
    @store      = @invoice.store
    @percentage = @invoice.fee_percentage/100.to_f
    @orders     = @invoice.store.orders.select do |order|
      order.created_at >= @invoice.start_date && order.created_at <= @invoice.end_date
    end

    refunds(@orders, @invoice)

    if @invoice.store.admins.include?(current_user) || (current_user && current_user.platform_administrator)
      render 'show'
    else
      flash[:error] = "Sorry, you are not authorized to access this page."
      redirect_to root_url
    end
  end

  def update
    invoice = Invoice.find(params[:id])
    if invoice.update_attributes(params[:invoice])
      flash.now[:alert] = "Successfully changed status of invoice."
      @url_date = Date.new(params[:year].to_i, params[:month].to_i) - 1.month
      @outstanding_balance = Invoice.outstanding_balance(@url_date)
    else
      flash.now[:error] = "Unable to mark invoice as paid"
    end
  end

  def pay
    session[:return_to] = request.referer

    @invoice = Invoice.find(params[:id])
    @fee     = params[:fee]
  end

  def submit_payment
    invoice = Invoice.find(params[:id])

    if invoice.update_attributes(params[:invoice])
      redirect_to session[:return_to],
        :notice => "Your invoice has been successfully paid."
    else
      render :pay, :notice => "We were unable to process your payment."
    end
  end

  def reminder_invoices
    invoice_dates(params)

      invoices = Invoice.find_unpaid_for(@start_date)
      invoices.each do |invoice|
        invoice.store.admins.each do |admin|
          UserMailer.delay.monthly_invoice_reminder(
            invoice.store, admin, @start_date
            )
        end
      end
    redirect_to :back,
      :notice => "Emails have been sent to unpaid invoice store admins."
  end

  def generate_invoices
    invoice_dates(params)

    @stores = Store.all
    @global_fee = GlobalFee.first

    @stores.each do |store|
      payments = store.payments(@start_date..@end_date)
      unless payments.empty?
        InvoiceService.create(payments, @global_fee)

        store.admins.each do |admin|
          UserMailer.delay.monthly_invoice(store, admin, @start_date)
        end
      end
    end
    redirect_to :back, :notice => "Your invoices have been created."
  end

  private

  def refunds(orders, invoice)
    order_refunds = []

    orders.each do |order|
      order.refunds.each { |refund| order_refunds << refund }
    end

    @refunds = order_refunds.select do |refund|
      refund.created_at >= invoice.start_date && refund.created_at <= invoice.end_date
    end

    @refunds
  end

  def invoice_dates(params)
    @date = Date.new(params[:year].to_i, params[:month].to_i)
    @start_date = @date - 1.month
    @end_date = @start_date.end_of_month
  end

  def require_admin
    unless current_user && current_user.platform_administrator
      flash[:error] = "Sorry, you are not authorized to access this page."
      redirect_to root_url
    end
  end
end
