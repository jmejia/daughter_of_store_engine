class Admin::OrdersController < ApplicationController
  def index
    @store   = Store.find_by_slug(params[:store_slug])
    @orders = @store.orders
  end
end