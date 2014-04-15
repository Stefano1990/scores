module SeriesHelper
  def series_active?(series)
    displayed = false
    case params[:controller]
      when 'series'
        case params[:action]
          when 'index' then displayed = false
          when 'show' then params[:id].to_i == series.id ? displayed = true : displayed = false
          when 'edit' then params[:id].to_i == series.id ? displayed = true : displayed = false
          when 'update' then params[:id].to_i == series.id ? displayed = true : displayed = false
        end
      when 'seasons'
        params[:series_id].to_i == series.id ? displayed = true : displayed = false
      when 'seasons'
        params[:series_id].to_i == series.id ? displayed = true : displayed = false
    end
    displayed
  end
end
