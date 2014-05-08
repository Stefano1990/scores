class SchedulesController < ApplicationController
  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update_attributes(params[:schedule])
      redirect_to league_series_season_path(@schedule.league,@schedule.series,@schedule.season), flash: { success: "Schedule was saved." }
    else
      render 'new'
    end
  end
end
