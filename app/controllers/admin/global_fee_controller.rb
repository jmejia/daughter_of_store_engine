class Admin::GlobalFeeController < ApplicationController
  def edit
    @global_fee = GlobalFee.first
  end
end
