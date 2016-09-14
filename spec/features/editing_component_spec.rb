require 'rails_helper'

RSpec.feature  "Edting a Flavor Component" do

	let(:flavor) {FactoryGirl.create(:flavor)}
	5.times do |n|
		let("ingredient#{n}".to_s) {FactoryGirl.create(:ingredient)}
	end
	let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient1)}
	let!(:component2) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient2)}

	scenario "Works properly" do

		visit flavor_path(flavor)

		within("div#component_#{component.id}") do
			click_link "Edit Ingredient"
		end

		fill_in "component[percentage]", with: 25
		click_button "Update Component"

		expect(page).to have_content("The component has been updated")
		expect(page).to have_content(flavor.name)
		expect(current_path).to eq flavor_path(flavor)
		within("div#component_#{component.id}") do
			expect(page).to have_content(25)
		end
	end
end