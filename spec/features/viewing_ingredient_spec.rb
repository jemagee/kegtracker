require 'rails_helper'

RSpec.feature "Viewing an ingredient" do

	let!(:ingredient) {FactoryGirl.create(:ingredient)}
	let!(:ingredient2) {FactoryGirl.create(:ingredient)}

	before {visit ingredients_path} 

	scenario "has all the ingredients on the index page" do

		within("div#ingredient_#{ingredient.id}") do
			expect(page).to have_link(ingredient.name)
		end

		within("div#ingredient_#{ingredient2.id}") do
			expect(page).to have_link(ingredient2.name)
		end
	end

	scenario "allows ingredient detail view from index page" do

		within("div#ingredient_#{ingredient.id}") do
			click_link ingredient.name
		end

		within("h1") do
			expect(page).to have_content(ingredient.name)
		end

		expect(page).to_not have_content(ingredient2.name)
		expect(page).to_not have_content("is used in the following flavors")
	end

	context "when the ingredient is used in a Flavor" do

		let!(:flavor) {FactoryGirl.create(:flavor)}
		let!(:flavor2) {FactoryGirl.create(:flavor)}

		

		before do
			FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient)
			visit ingredient_path(ingredient)
		end

		scenario "the flavor name is a link to the flavor page" do

			within("h3#component_usage") do
				expect(page).to have_content("#{ingredient.name.capitalize} is used in the following flavors")
			end
			within("div#flavor_#{flavor.id}") do
				expect(page).to have_link(flavor.name)
			end

			expect(page).to_not have_link(flavor2.name)
		end
	end
end