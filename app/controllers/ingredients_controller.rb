class IngredientsController < ApplicationController
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
    @ingredient = Ingredient.find(params[:id])
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
end
