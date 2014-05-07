class StandingsController < ApplicationController
  def show
    @standing = Standing.find(params[:id])
  end

  def index
    @graphic = Graphic.find(params[:graphic_id])
    @standings = @graphic.standings
  end

  def new
    @graphic = Graphic.find(params[:graphic_id])
    @standing = @graphic.standings.new
  end

  def create
    @graphic = Graphic.find(params[:graphic_id])
    @standing = @graphic.standings.new(params[:standing])
    if @standing.save
      redirect_to graphic_standings_path(@graphic), flash: { success: "Standings created." }
    else
      render 'new'
    end
  end

  def refresh
    @standing = Standing.find(params[:standing_id])
    if @standing.make_image
      #redirect_to graphic_standings_path(@standing.graphic, @standing.graphic.user), flash: { success: "Standings refreshed." }
      render 'refresh-success', layout: false
    else
      #redirect_to graphic_standings_path(@standing.graphic, @standing.graphic.user), flash: { error: "There was an error refreshing the standings." }
      render 'refresh-error', layout: false
    end
  end

  def destroy
    @standing = Standing.find(params[:id])
    if @standing.destroy
      redirect_to graphic_standings_path(@standing.graphic), flash: { success: "Standings deleted." }
    end
  end
end
