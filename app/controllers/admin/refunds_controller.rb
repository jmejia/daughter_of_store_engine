class Admin::RefundsController < ApplicationController

  def new
    @order = Order.new
    @store_slug = params[:store_slug]
  end

  def create
    @order = Order.find(params[:id])
  end
end