class StandingsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @league = @user.leagues.find(params[:league_id])
    @standing = @league.standings.new
  end

  def create
    @user = User.find(params[:user_id])
    @league = @user.leagues.find(params[:league_id])
    @standing = @league.standings.new(params[:standing])
    if @standing.save
      redirect_to user_league_path(@league, @league.user), flash: { success: "Result updated." }
    else
      render 'new'
    end
  end
end
