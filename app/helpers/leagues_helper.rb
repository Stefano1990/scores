module LeaguesHelper
  def league_displayed?(league)
    displayed = false
    case params[:controller]
      when 'leagues'
        case params[:action]
          when 'index' then displayed = false
          when 'show' then params[:id].to_i == league.id ? displayed = true : displayed = false
          when 'edit' then params[:id].to_i == league.id ? displayed = true : displayed = false
          when 'update' then params[:id].to_i == league.id ? displayed = true : displayed = false
        end
      when 'results'
        params[:league_id].to_i == league.id ? displayed = true : displayed = false
      when 'standings'
        params[:league_id].to_i == league.id ? displayed = true : displayed = false
    end
    displayed
  end
end
