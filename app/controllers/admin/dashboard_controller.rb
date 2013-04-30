class Admin::DashboardController < ApplicationController
  load_and_authorize_resource

  def show
    @current_date = Date.today.beginning_of_month
  end
end
