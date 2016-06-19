class FlavorsController < ApplicationController

  def new
    @flavor = Flavor.new
  end

  def create
    @flavor = Flavor.new(flavor_params)
    if @flavor.save
      flash[:success] = "Flavor has been added"
      redirect_to @flavor
    else
      flash.now[:warning] = "The flavor was not created"
      render 'new'
    end
  end

  def show
    @flavor = Flavor.find(params[:id])
  end

  private

  def flavor_params
    params.require(:flavor).permit(:name, :abbreviation)
  end
end
