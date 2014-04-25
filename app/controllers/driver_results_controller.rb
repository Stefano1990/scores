class DriverResultsController < ApplicationController
  def edit
    @driver_result = DriverResult.find(params[:id])
  end

  def update
    @driver_result = DriverResult.find(params[:id])
    if @driver_result.update_attributes(params[:driver_result])
      redirect_to league_series_season_result_path(@driver_result.league,@driver_result.series,@driver_result.season,@driver_result.result), flash: { success: "Driver result updated." }
    else
      render 'edit'
    end
  end
end
