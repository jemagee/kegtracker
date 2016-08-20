class IngredientsController < ApplicationController

  before_action :get_ingredient, only: [:edit, :update, :show, :destroy]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "The ingredient has been added"
      redirect_to @ingredient
    else
      flash.now[:warning] = "The ingredient was not added"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ingredient.update_attributes(ingredient_params)
      flash[:success] = "Ingredient was updated"
      redirect_to @ingredient
    else
      flash.now[:warning] = "Ingredient was not updated"
      render 'edit'
    end
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

    def get_ingredient
      @ingredient = Ingredient.find(params[:id])
    end
end
