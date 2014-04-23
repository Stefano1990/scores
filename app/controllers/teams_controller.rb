class TeamsController < ApplicationController
  before_filter     :initialize_variables

  def index
    @teams = @season.teams
  end

  def new
    @team = @season.teams.new
  end

  def create
    @team = @season.teams.new(params[:team])
    if @team.save
      redirect_to league_series_season_teams_path(@league,@series,@season), flash: { success: "Team was saved." }
    else
      render 'new'
    end
  end

  def edit
    @team = @season.teams.find(params[:id])
  end

  def update
    @team = @season.teams.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to league_series_season_teams_path(@league,@series,@season), flash: { success: "Team was updated." }
    else
      render 'edit'
    end
  end

  private

  def initialize_variables
    @league = League.find(params[:league_id])
    @series = @league.series.find(params[:series_id])
    @season = @series.seasons.find(params[:season_id])
  end
end
