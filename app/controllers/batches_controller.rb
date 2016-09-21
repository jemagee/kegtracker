class BatchesController < ApplicationController

  before_action :get_batch, only: [:edit, :show, :update]

  def new
    @batch = Batch.new
  end

  def create 
    @batch = Batch.new(batch_params)

   if  @batch.save
      flash[:success] = "The batch was created"
      redirect_to @batch
    else
      flash[:warning] = "The batch was not created"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if !(@batch.flavor_id == params[:batch][:flavor_id])
      @batch.lot[0..3] = Flavor.find(params[:batch][:flavor_id]).abbreviation
    end
    if @batch.update_attributes(batch_params)
      flash[:success] = "The batch has been updated"
      redirect_to @batch
    else
      flash[:warning] = "The batch was not changed"
      render 'edit'
    end
  end



  private

    def batch_params
      params.require(:batch).permit(:flavor_id, :gallons)
    end

    def get_batch
      @batch = Batch.find(params[:id])
    end
end
