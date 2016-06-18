class KegsController < ApplicationController

  before_action :find_keg, only: [:show, :edit, :update, :destroy]

  def new
    @keg = Keg.new
  end

  def create
    @keg = Keg.new(keg_params)
    if @keg.save
      flash[:success] = "Keg has been added"
      redirect_to @keg
    else
      flash.now[:warning] = "The keg was not added"
      render 'new'
    end
  end

  def index
    @kegs = Keg.all
  end

  def show
  end

  def edit
  end

  def update
    if @keg.update(keg_params)
      flash[:success] = "The keg was updated successfully"
      redirect_to @keg
    else
      flash.now[:warning] = "The keg was not updated"
      render 'edit'
    end
  end


  private

    def keg_params
      params.require(:keg).permit(:serial_number)
    end

    def find_keg
      @keg = Keg.find(params[:id])
    end
end
