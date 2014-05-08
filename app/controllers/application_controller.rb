class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    user_graphics_path(current_user)
  end

  def current_league
    find_current(@current_league,:league_id,League,"leagues")
  end
  helper_method :current_league

  def current_series
    find_current(@current_series,:series_id,Series,"series")
  end
  helper_method :current_series

  def current_season
    find_current(@current_season,:season_id,Season,"season")
  end
  helper_method :current_season


  private
  def find_current(model,symbol,model_class,controller)
    if model.nil? || model.id != params[symbol]
      if session[symbol]
        model = model_class.find(session[symbol])
      else
        if params[:controller] == controller && params[:action] == "show" && params[:id]
          model = model_class.find(params[:id])
        end
      end
    end
    session[symbol] = model.id if model
    model
  end
end
