class PointSystemsController < ApplicationController
  def new
    @season = Season.find(params[:season_id])
    @point_system = @season.build_point_system
  end

  def create
    @season = Season.find(params[:season_id])
    @point_system = @season.build_point_system(params[:point_system])
    if @point_system.save
      redirect_to league_series_season_path(@season.league,@season.series,@season), flash:
                                                                                { success: "Points saved." }
    else
      render 'new'
    end
  end
end
