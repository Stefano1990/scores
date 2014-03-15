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
      redirect_to user_leagues_path(@user), flash: { success: "League created." }
    else
      render 'new'
    end
  end

  def refresh
    @league = current_user.leagues.find(params[:id])
    @league.refresh
  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])
    if @league.update_attributes(params[:league])
      redirect_to leagues_path, flash: { success: "League was updated." }
    else
      render 'edit'
    end
  end
end
