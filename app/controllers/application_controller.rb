class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    user_graphics_path(current_user)
  end

  def current_league
    if @current_league.nil?
      if session[:league_id]
        @current_league = League.find(session[:league_id])
        session[:league_id] = @current_league.id
      else
        if params[:league_id]
          @current_league = League.find(session[:league_id])
          session[:league_id] = @current_league.id
        end
        if params[:controller] == 'leagues' && params[:action] == 'index'
          @current_league = nil
        end
        if params[:controller] == 'leagues' && params[:action] == 'show'
          @current_league = League.find(params[:id])
          session[:league_id] = @current_league.id
        end
      end
    end
    @current_league
  end
  helper_method :current_league

  def current_season
    if @current_season.nil?
      @current_season = current_league.series.last.seasons.last

    end
    @current_season
  end
  helper_method :current_season
end
