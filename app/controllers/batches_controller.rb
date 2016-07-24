class BatchesController < ApplicationController

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
    @batch = Batch.find(params[:id])
  end


  private

    def batch_params
      params.require(:batch).permit(:flavor_id, :gallons)
    end
end
