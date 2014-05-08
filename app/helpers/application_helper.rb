module ApplicationHelper
  def clippy(text, bgcolor='#FFFFFF')
    html = <<-EOF
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
            width="110"
            height="14"
            id="clippy" >
    <param name="movie" value="/flash/clippy.swf"/>
    <param name="allowScriptAccess" value="always" />
    <param name="quality" value="high" />
    <param name="scale" value="noscale" />
    <param NAME="FlashVars" value="text=#{text}">
    <param name="bgcolor" value="#{bgcolor}">
    <embed src="/flash/clippy.swf"
           width="110"
           height="14"
           name="clippy"
           quality="high"
           allowScriptAccess="always"
           type="application/x-shockwave-flash"
           pluginspage="http://www.macromedia.com/go/getflashplayer"
           FlashVars="text=#{text}"
           bgcolor="#{bgcolor}"
    />
    </object>
    EOF
  end

  def breadcrumbs
    output = ""
    output << crumb_link(current_league.name,league_path(current_league)) if params[:league_id]
    output << crumb_link(current_series.name,league_series_path(current_league,current_series)) if params[:series_id]
    output << crumb_link(current_season.name,league_series_season_path(current_league,current_series,current_season)) if params[:season_id]
    if params[:action] == "show"
      case params[:controller]
        when "leagues" then output << crumb_link(current_league.name)
        when "series" then output << crumb_link(current_series.name)
        when "seasons" then output << crumb_link(current_season.name)
      end
    end
    output.html_safe
  end

  def crumb_link(string, path=nil)
    if path then "<li>#{link_to string, path}</li>" else "<li>#{string}</li>" end
  end
end
