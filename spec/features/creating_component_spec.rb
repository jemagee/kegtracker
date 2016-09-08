require 'rails_helper'

RSpec.feature "Adding Flavor Components" do

	let(:flavor) {FactoryGirl.create(:flavor)}
	let(:flavor2) {FactoryGirl.create(:flavor)}

	5.times do |n|
		let!("ingredient#{n}".to_s) { FactoryGirl.create(:ingredient) }
	end

	before do

		visit flavor_path(flavor)
		click_link "Add Component"

	end

	scenario "Adding a comoponent properly" do

		select ingredient2.name, from: "component[ingredient_id]"
		fill_in "component[percentage]", with: 25

		click_button "Add Component"

		expect(page).to have_content("#{ingredient2.name} was added to the recipe for #{flavor.name}")
		within("div.header") do
			expect(page).to have_content(flavor.name)
		end
		within("div.components") do
			expect(page).to have_content(ingredient2.name)
		end
	end 

	context "With Valid Ingredient Percentages" do

		before do
			select ingredient2.name, from: "component[ingredient_id]"
		end

		scenario  "requires the presence of an ingredient percentage" do

			click_button "Add Component"

			expect(page).to have_content("The component was not added")
			expect(page).to have_content("You must include a percentage for an ingredient")
		end

		scenario "requires the presence of a number" do

			fill_in "component[percentage]", with: "abc"

			click_button "Add Component"

			expect(page).to have_content("The component was not added")
			expect(page).to have_content("Percentage must be a number")
		end

		scenario "requires a number no larger than 100" do

			fill_in "component[percentage]", with: 100.00001

			click_button "Add Component"

			expect(page).to have_content("The component was not added")
			expect(page).to have_content("An ingredient percentage can not exceed 100%")
		end
	end

	context "Does not allow the same component to be added twice" do

		before  {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient4)}

		scenario "Duplicated component can not be added" do
			select ingredient4.name, from: "component[ingredient_id]"
			fill_in "component[percentage]", with: 13

			click_button "Add Component"

			expect(page).to have_content("The component was not added")
			expect(page).to have_content("This ingredient is already part of the flavor recipe")
		end

		scenario "Same Ingredient can be added to a different flavor" do

			visit flavor_path(flavor2)
			click_link "Add Component"
			select ingredient4.name, from: "component[ingredient_id]"
			fill_in "component[percentage]", with: 13

			click_button "Add Component"

			expect(page).to have_content("#{ingredient4.name} was added to the recipe for #{flavor2.name}")
		end
	end	

	context "Checking the flavor component limitations" do

		before {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient4, percentage: 100)}

		scenario "Does not allow an a flavors compopnents to add up to more than 100" do

	
			select ingredient3.name, from: "component[ingredient_id]"
			fill_in "component[percentage]", with: 3.7

		  click_button "Add Component"

			expect(page).to have_content("The component was not added")
			expect(page).to have_content("The total of all a flavors components can not exceed 100 percent")
		end
	end
end
