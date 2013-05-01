class HomeController < ApplicationController
  def show
    @products = []
    @stores = Store.order("name")
  end
end
