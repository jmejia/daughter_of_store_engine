class Admin::OrdersController < ApplicationController
  def new_refund
    @order = Order.new
  end

  def process_refund
    @order = Order.find(params[:id])
  end
end