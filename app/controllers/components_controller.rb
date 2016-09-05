class ComponentsController < ApplicationController
  
	before_action :get_flavor

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

  private

  	def get_flavor
  		@flavor = Flavor.find(params[:flavor_id])
  	end

  	def component_params
  		params.require(:component).permit(:ingredient_id, :percentage)
  	end
end
