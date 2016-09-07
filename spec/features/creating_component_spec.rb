require 'rails_helper'

RSpec.feature "Adding Flavor Components" do

	let(:flavor) {FactoryGirl.create(:flavor)}

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
end
