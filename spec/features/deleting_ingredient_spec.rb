require 'rails_helper'

RSpec.feature "Deleting an ingredient" do

	let(:ingredient) {FactoryGirl.create(:ingredient)}
	let(:flavor) {FactoryGirl.create(:flavor)}

	scenario "deletes the ingredient if it's not part of any flavors" do

		visit ingredient_path(ingredient)
		click_link "Delete #{ingredient.name}"

		expect(page).to have_content("The ingredient was deleted")
		expect(current_path).to eq(ingredients_path)
	end
end

