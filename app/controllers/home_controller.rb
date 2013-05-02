class HomeController < ApplicationController
  def show
    @stores = Store.order("name")
    @featured_stores = @stores[0..2]
  end
end
