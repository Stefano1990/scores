class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    user_graphics_path(current_user)
  end

  def current_league
    if @current_league.nil?
      if session[:league_id]
        @current_league = League.find(session[:league_id])
      else
        if params[:controller] == 'leagues' && params[:action] == 'show'
          @current_league = League.find(params[:id])
        end
      end
      session[:league_id] = @current_league.id
    end
    @current_league
  end
  helper_method :current_league
end
