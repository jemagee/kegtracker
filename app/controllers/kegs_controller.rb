class KegsController < ApplicationController
  def new
    @keg = Keg.new
  end

  def create
    @keg = Keg.new(keg_params)
    if @keg.save
      flash[:success] = "Keg has been added"
      redirect_to @keg
    else
      flash[:warning] = "The keg was not added"
      render 'new'
    end
  end

  def index
    @kegs = Keg.all
  end

  def show
    @keg = Keg.find(params[:id])
  end

  private

    def keg_params
      params.require(:keg).permit(:serial_number)
    end
end
