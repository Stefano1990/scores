class LeaguesController < ApplicationController
  before_filter :find_user
  def index
    @leagues = @user.leagues
  end

  def show
    @league = League.find(params[:id])
  end

  def new
    @league = @user.leagues.new
  end

  def create
    @league = @user.leagues.new(params[:league])
    if @league.save
      redirect_to user_leagues_path(@user), flash: { success: "League created." }
    else
      render 'new'
    end
  end

  def refresh
    @league = @user.leagues.find(params[:id])
    @league.refresh
  end


  private
  def find_user
    @user = User.find(params[:user_id])
  end
end
