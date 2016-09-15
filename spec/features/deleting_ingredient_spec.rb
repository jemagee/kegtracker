require 'rails_helper'

RSpec.feature "Deleting an ingredient" do

	let(:ingredient) {FactoryGirl.create(:ingredient)}
	let(:flavor) {FactoryGirl.create(:flavor)}

	before { visit ingredient_path(ingredient) }

	scenario "deletes the ingredient if it's not part of any flavors" do

		click_link "Delete #{ingredient.name}"

		expect(page).to have_content("The ingredient was deleted")
		expect(current_path).to eq(ingredients_path)
		expect(page).to_not have_selector("span#archived")
	end

	scenario "will archive, instead of delete, and ingredient when it is part of a flavor" do
		FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient)

		click_link "Delete #{ingredient.name}"

		expect(page).to have_content("The ingredient has been archived, it could not be deleted")
		within("span#archived") do
			expect(page).to have_content("ARCHIVED")
		end
		expect(current_path).to eq(ingredient_path(ingredient))
	end
end

