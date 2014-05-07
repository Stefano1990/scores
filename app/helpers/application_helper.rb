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
    controller = params[:controller]
    action = params[:action]
    if current_season
      league = current_season.league
      series = current_season.series
      season = current_season
      output << crumb_link(current_season.league.name, league_path(league))
      output << crumb_link(current_season.series.name, league_series_path(league,series))
      output << crumb_link(current_season.name, league_series_season_path(league,series,season))
    end
    if controller == "standings" && action == "show" then output << crumb_link("Standing") end
    if controller == "results" && action == "show" then output << crumb_link("Result") end
    output.html_safe
  end

  def crumb_link(string, path=nil)
    if path then "<li>#{link_to string, path}</li>" else "<li>#{string}</li>" end
  end
end
