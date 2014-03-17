class LeaguesController < ApplicationController
  def index
    @leagues = current_user.leagues
  end

  def show
    @league = League.find(params[:id])
    @results = @league.results
    @standings = @league.standings
  end

  def new
    @league = current_user.leagues.new
  end

  def create
    @league = current_user.leagues.new(params[:league])
    if @league.save
      redirect_to leagues_path, flash: { success: "League created." }
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
    begin
      @league = League.find(params[:id])
      config = JSON.parse(params[:league][:config]) # Check if the config is valid.
      if @league.config != params[:league][:config]
        config_has_changed = true
      end
      if @league.update_attributes(params[:league])
        if config_has_changed
          @league.expire_standings_and_results!
        end
        redirect_to leagues_path, flash: { success: "League was updated." }
      else
        render 'edit'
      end
    rescue JSON::ParserError
      flash[:error] = 'Config contains JSON errors. (Check line numbers for i and X)'
      @league.config = params[:league][:config]
      render 'edit'
    end

  end
end
