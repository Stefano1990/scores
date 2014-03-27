class ResultsController < ApplicationController
  def index
    @league = League.find(params[:league_id])
    @results = @league.results
  end

  def new
    @league = League.find(params[:league_id])
    @result = @league.results.new
  end

  def create
    @league = League.find(params[:league_id])
    @result = @league.results.new(params[:result])
    if @result.save
      redirect_to league_results_path(@league), flash: { success: "Result created." }
    else
      render 'new'
    end
  end

  def refresh
    @result = Result.find(params[:result_id])
    if @result.make_image
      #redirect_to league_Results_path(@result.league, @result.league.user), flash: { success: "Results refreshed." }
      render 'refresh-success', layout: false
    else
      #redirect_to league_Results_path(@result.league, @result.league.user), flash: { error: "There was an error refreshing the Results." }
      render 'refresh-error', layout: false
    end
  end

  def destroy
    @result = Result.find(params[:id])
    if @result.destroy
      redirect_to league_results_path(@result.league), flash: { success: "Results destroyed." }
    else
      redirect_to league_results_path(@result.league), flash: { error: "Results were not destroyed." }
    end
  end
end
