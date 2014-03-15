class StandingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @league = League.find(params[:league_id])
    @standings = @league.standings
  end

  def new
    @user = current_user
    @league = @user.leagues.find(params[:league_id])
    @standing = @league.standings.new
  end

  def create
    @league = League.find(params[:league_id])
    @standing = @league.standings.new(params[:standing])
    if @standing.save
      redirect_to user_league_path(@league, @league.user), flash: { success: "Result updated." }
    else
      render 'new'
    end
  end
end
