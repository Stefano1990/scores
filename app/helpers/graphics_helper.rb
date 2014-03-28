module GraphicsHelper
  def graphic_displayed?(graphic)
    displayed = false
    case params[:controller]
      when 'graphics'
        case params[:action]
          when 'index' then displayed = false
          when 'show' then params[:id].to_i == graphic.id ? displayed = true : displayed = false
          when 'edit' then params[:id].to_i == graphic.id ? displayed = true : displayed = false
          when 'update' then params[:id].to_i == graphic.id ? displayed = true : displayed = false
        end
      when 'results'
        params[:graphic_id].to_i == graphic.id ? displayed = true : displayed = false
      when 'standings'
        params[:graphic_id].to_i == graphic.id ? displayed = true : displayed = false
    end
    displayed
  end
end
