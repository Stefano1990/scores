class SeriesController < ApplicationController
  def index
    @league = League.find(params[:league_id])
    @series = @league.series
  end

  def show
    @league = League.find(params[:league_id])
    @series = @league.series.find(params[:id])
  end

  def new
    @league = League.find(params[:league_id])
    @series = @league.series.new
  end

  def create
    @league = League.find(params[:league_id])
    @series = @league.series.new(params[:series])
    if @series.save
      redirect_to league_series_path(@league,@series), flash: { success: "Series created." }
    else
      render 'new'
    end
  end
end
