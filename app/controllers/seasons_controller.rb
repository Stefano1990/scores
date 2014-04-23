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

  def update
    @league = League.find(params[:league_id])
    @series = @league.series.find(params[:series_id])
    @season = @series.seasons.find(params[:id])
    begin
      config = JSON.parse(params[:season][:config]) # Check if the config is valid.

      if params[:commit] == "Preview" # Only preview, don't save the config yet.
        @season.config = params[:season][:config]
        @season.generate_preview
        render 'edit'
      else
        if @season.config != params[:season][:config]
          config_has_changed = true
        end
        if @season.update_attributes(params[:season])
          if config_has_changed
            #@season.expire_standings_and_results!
          end
          redirect_to edit_league_series_season_path(@league,@series,@season), flash: { success: "Season was updated." }
        else
          render 'edit'
        end
      end
    rescue JSON::ParserError
      flash[:error] = 'Config contains JSON errors. (Check line numbers for i and X)'
      @season.config = params[:season][:config]
      render 'edit'
    end
  end
end
