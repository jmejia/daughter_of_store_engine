class Admin::GlobalFeeController < ApplicationController
  def edit
    @global_fee = GlobalFee.first
  end

  def update
    global_fee = GlobalFee.first
    if global_fee.update_attributes(params[:global_fee])
      flash[:success] = "Updated the Global Fee to #{GlobalFee.first.amount}%."
      redirect_to admin_dashboard_path
    else
      flash[:alert] = "Unable to update the Global Fee."
    end
  end


end
