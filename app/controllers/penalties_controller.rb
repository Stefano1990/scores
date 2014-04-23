class PenaltiesController < ApplicationController
  before_filter   :initialize_variables

  def new
    @penalty = @driver_result.penalties.new
  end

  def create
    @penalty = @driver_result.penalties.new(params[:penalty])
    if @penalty.save
      @penalty.apply
      redirect_to league_series_season_result_path(@penalty.league,
                                                   @penalty.series,
                                                   @penalty.season,
                                                   @penalty.result), flash: { success: "Penalty applied." }
    else
      render 'new'
    end
  end

  def edit
    @penalty = @driver_result.penalties.find(params[:id])
  end

  def update
    @penalty = @driver_result.penalties.find(params[:id])
    if @penalty.update_attributes(params[:penalty])
      @penalty.apply
      redirect_to league_series_season_result_path(@penalty.league,@penalty.series,@penalty.season,@penalty.result),
                                                      flash: { success: "Penalty updated." }
    else
      render 'edit'
    end
  end

  private

  def initialize_variables
    @driver_result = DriverResult.find(params[:driver_result_id])
  end
end
