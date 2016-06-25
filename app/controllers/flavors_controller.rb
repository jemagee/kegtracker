class FlavorsController < ApplicationController

  before_action :get_flavor, only: [:show, :edit, :destroy]

  def index
    @flavors = Flavor.all
  end
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
  end

  def destroy
    @flavor.archive
    flash[:success] = "#{@flavor.name} has been successfully archived"
    redirect_to flavors_path
  end

  private

  def flavor_params
    params.require(:flavor).permit(:name, :abbreviation)
  end

  def get_flavor
    @flavor = Flavor.find(params[:id])
  end
end
