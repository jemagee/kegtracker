class ComponentsController < ApplicationController

  before_action :get_flavor
  before_action :get_component, only: [:edit, :update, :destroy, :show]

  def new
  	@component = @flavor.components.build
  end

  def create
  	@component = @flavor.components.build(component_params)
  	if @component.save
  		flash[:success] = "#{@component.ingredient.name} was added to the recipe for #{@flavor.name}"
  		redirect_to @flavor
  	else
  		flash.now[:warning] = "The component was not added to the flavor recipe"
  		render 'new'
  	end
  end

  def show
  end

  def edit
  end

  def update
    @component.update(component_params)
    flash[:success] = "The component has been updated"
    redirect_to @flavor
  end

  def destroy
    @component.destroy
    flash[:success] = "The component has been removed from the recipe"
    redirect_to @flavor
  end

  private

  	def get_flavor
  		@flavor = Flavor.find(params[:flavor_id])
  	end

  	def component_params
  		params.require(:component).permit(:ingredient_id, :percentage)
  	end

    def get_component
      @component = @flavor.components.find(params[:id])
    end
end
