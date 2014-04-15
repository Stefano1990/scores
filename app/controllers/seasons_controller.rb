class SeasonsController < ApplicationController
  def index
    @season = current_user.seasons
  end

  def show
    @league = League.find(params[:league_id])
    @series = @league.series.find(params[:series_id])
    @season = @series.seasons.find(params[:id])
  end

  def new
    @league = League.find(params[:league_id])
    @series = @league.series.find(params[:series_id])
    @season = @series.seasons.new
  end

  def create
    @league = League.find(params[:league_id])
    @series = @league.series.find(params[:series_id])
    @season = @series.seasons.new(params[:season])
    if @series.save
      redirect_to league_series_season_path(@league,@series,@season), flash: { success: "Season created." }
    else
      render 'new'
    end
  end

  def edit
    @league = League.find(params[:league_id])
    @series = @league.series.find(params[:series_id])
    @season = @series.seasons.find(params[:id])
  end


end
