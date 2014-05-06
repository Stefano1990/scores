class ResultsController < ApplicationController
  def show
    @result = Result.find(params[:id])
  end

  def index
  end

  def new
    @season = Season.find(params[:season_id])
    @result = @season.results.new
  end

  def create
    @season = Season.find(params[:season_id])
    @result = @season.results.new(params[:result])
    if @result.save
      redirect_to season_result_path(@season,@result), flash: { success: "Result created." }
    else
      render 'new'
    end
  end

  def refresh
    @result = Result.find(params[:result_id])
    if @result.make_image
      #redirect_to graphic_results_path(@result.graphic, @result.graphic.user), flash: { success: "Results refreshed." }
      render 'refresh-success', layout: false
    else
      #redirect_to graphic_results_path(@result.graphic, @result.graphic.user), flash: { error: "There was an error refreshing the Results." }
      render 'refresh-error', layout: false
    end
  end

  def destroy
    @result = Result.find(params[:id])
    if @result.destroy
      redirect_to graphic_results_path(@result.graphic), flash: { success: "Results destroyed." }
    else
      redirect_to graphic_results_path(@result.graphic), flash: { error: "Results were not destroyed." }
    end
  end
end
