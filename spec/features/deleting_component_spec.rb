require 'rails_helper' 

RSpec.feature "Deleting a component" do

	let!(:flavor) {FactoryGirl.create(:flavor)}
	let!(:ingredient) {FactoryGirl.create(:ingredient)}
	let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient)}

	before {visit flavor_component_path(flavor, component)}

	scenario "works" do
		click_link "Delete Component"

		expect(page).to have_content("The component has been removed from the recipe")
		expect(current_path).to eq flavor_path(flavor)
	end
end
