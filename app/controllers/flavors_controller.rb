class FlavorsController < ApplicationController

  before_action :get_flavor, only: [:show, :edit, :destroy, :update]

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

  def edit
  end

  def update
    if @flavor.update_attributes(flavor_params)
      flash[:success] = "The flavor was updated"
      redirect_to @flavor
    else
      flash[:warning] = "The flavor was not updated"
      render 'edit'
    end
  end

  def destroy
    @flavor.destroy
    flash[:success] = "#{@flavor.name} has been successfully archived"
    redirect_to flavors_path
  end

  private

  def flavor_params
    params.require(:flavor).permit(:name, :abbreviation, :gpg)
  end

  def get_flavor
    @flavor = Flavor.find(params[:id])
  end
end
