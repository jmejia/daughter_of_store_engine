class Admin::RefundsController < ApplicationController
  def new
    @order = Order.find(params[:id])
    @store_slug = params[:store_slug]
  end

  def create
    @order = Order.find(params[:id])
    RefundService.create(@order)

    redirect_to admin_orders_path, :notice => "A refund for Order # #{@order.id} is been created"
  end
end