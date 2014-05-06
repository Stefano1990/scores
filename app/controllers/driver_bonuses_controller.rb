class DriverBonusesController < ApplicationController
  def new
    @driver_result = DriverResult.find(params[:driver_result_id])
    @driver_bonus = @driver_result.build_driver_bonus
  end
end
