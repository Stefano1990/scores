class GraphicsController < ApplicationController
  def index
    @graphics = current_user.graphics
  end

  def show
    @graphic = Graphic.find(params[:id])
    @results = @graphic.results
    @standings = @graphic.standings
  end

  def new
    @graphic = current_user.graphics.new
  end

  def create
    @graphic = current_user.graphics.new(params[:graphic])
    if @graphic.save
      redirect_to graphics_path, flash: { success: "Graphic created." }
    else
      render 'new'
    end
  end

  def refresh
    @graphic = current_user.graphics.find(params[:id])
    @graphic.refresh
  end

  def edit
    @graphic = Graphic.find(params[:id])
  end

  def update
    begin
      @graphic = Graphic.find(params[:id])
      config = JSON.parse(params[:graphic][:config]) # Check if the config is valid.

      if params[:commit] == "Preview" # Only preview, don't save the config yet.
        @graphic.config = params[:graphic][:config]
        @graphic.generate_preview
        render 'edit'
      else
        if @graphic.config != params[:graphic][:config]
          config_has_changed = true
        end
        if @graphic.update_attributes(params[:graphic])
          if config_has_changed
            @graphic.expire_standings_and_results!
          end
          redirect_to graphics_path, flash: { success: "Graphic was updated." }
        else
          render 'edit'
        end
      end
    rescue JSON::ParserError
      flash[:error] = 'Config contains JSON errors. (Check line numbers for i and X)'
      @graphic.config = params[:graphic][:config]
      render 'edit'
    end
  end

  def destroy
    @graphic = Graphic.find(params[:id])
    if @graphic.destroyed
      redirect_to graphics_path, flash: { success: "Graphic destroyed." }
    else
      redirect_to graphics_path, flash: { error: "Graphic was not destroyed." }
    end
  end
end
