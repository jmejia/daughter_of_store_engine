class Admin::RefundsController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.find(params[:id])
  end
end