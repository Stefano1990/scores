class LeaguesController < ApplicationController
  def index
    @leagues = current_user.leagues
  end

  def show
    @league = League.find(params[:id])
  end

  def new
    @league = current_user.leagues.new
  end

  def create
    @league = current_user.leagues.new(params[:league])
    if @league.save
      redirect_to league_path(@league), flash: { success: "League created." }
    else
      render 'new'
    end
  end
end
