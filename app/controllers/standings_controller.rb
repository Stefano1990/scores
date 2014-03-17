class StandingsController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @league = League.find(params[:league_id])
    @standings = @league.standings
  end

  def new
    @league = League.find(params[:league_id])
    @standing = @league.standings.new
  end

  def create
    @league = League.find(params[:league_id])
    @standing = @league.standings.new(params[:standing])
    if @standing.save
      redirect_to league_standings_path(@league), flash: { success: "Standings created." }
    else
      render 'new'
    end
  end

  def refresh
    @standing = Standing.find(params[:standing_id])
    if @standing.make_image
      #redirect_to league_standings_path(@standing.league, @standing.league.user), flash: { success: "Standings refreshed." }
      render 'refresh-success', layout: false
    else
      #redirect_to league_standings_path(@standing.league, @standing.league.user), flash: { error: "There was an error refreshing the standings." }
      render 'refresh-error', layout: false
    end
  end
end
