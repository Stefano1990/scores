class ResultConfigsController < ApplicationController
  def new
    @standing = Standing.find(params[:standing_id])
    @standing_config = @standing.build_standing_config
  end

  def create
    @standing = Standing.find(params[:standing_id])
    @standing_config = @standing.build_standing_config(params[:standing_config])
    if @standing_config.save
      @standing.update_attribute(:standing_config, @standing_config)
      redirect_to :back, flash: { success: "config saved." }
    else
      render 'new'
    end
  end

  def update

  end
end
