require 'rails_helper'

RSpec.feature "Viewing a flavor" do

	let!(:flavor) {FactoryGirl.create(:flavor)}
	let!(:flavor1) {FactoryGirl.create(:flavor)}
	let(:ingredient) {FactoryGirl.create(:ingredient)}


	before {visit flavors_path}


	scenario "works from the flavor index page" do


		within("div#flavor_#{flavor.id}") {click_link "Flavor Detail"}

		expect(page).to have_content(flavor.name)
		expect(page).to have_content(flavor.abbreviation)
		expect(page).to_not have_content(flavor1.name)
		expect(page).to have_content "Batches of this flavor can not be made until the both the recipe is set and the grams per gallon is entered"
	end

	context "with an eligible component makeup" do


		before do 
			FactoryGirl.create(:component, flavor: flavor1, ingredient: ingredient, percentage: 100)
		end

		scenario "without valid gpg setting" do

			within("div#flavor_#{flavor1.id}") {click_link "Flavor Detail"}
			expect(page).to have_content(flavor1.name)
			expect(page).to_not have_link "Create Batch"
			expect(page).to_not have_link "Create FULL Batch"
			within("span.warning") do
				expect(page).to have_content "Batches of this flavor can not be made until the both the recipe is set and the grams per gallon is entered"
			end
		end

		context "with a set gpg" do

			before do
				flavor1.update_attributes(gpg: 100)
			end

			scenario "has links to create a batch and a full batch" do
				within("div#flavor_#{flavor1.id}") {click_link "Flavor Detail"}

				expect(page).to have_content(flavor1.name)
				expect(page).to have_content(flavor1.abbreviation)
				expect(page).to have_link "Create Batch"
				expect(page).to have_link "Create FULL Batch"
			end
		end
	end


	context "with an ineliglbe component combination but valid grams per gallons" do

		before do
			FactoryGirl.create(:component, flavor: flavor1, ingredient: ingredient, percentage: 99)
			flavor1.update_attributes(gpg: 100)
		end

		scenario "will not have links to create any batches" do
			
			within("div#flavor_#{flavor1.id}") {click_link "Flavor Detail"}

			expect(page).to have_content(flavor1.name)
			expect(page).to_not have_link "Create Batch"
			expect(page).to_not have_link "Create FULL Batch"
			within("span.warning") do
				expect(page).to have_content "Batches of this flavor can not be made until the both the recipe is set and the grams per gallon is entered"
			end
		end
	end
end