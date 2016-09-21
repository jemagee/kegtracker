require 'rails_helper'

RSpec.feature "Editing a Batch" do

	let!(:flavor) {FactoryGirl.create(:flavor)}
	let(:batch) {FactoryGirl.create(:batch, flavor: flavor, gallons: 15)}
	let!(:flavor2) {FactoryGirl.create(:flavor)}

	before  do
		visit batch_path(batch)
		click_link "Edit Batch"
	end

	scenario "Works with valid changes" do

		select flavor2.name, from: "batch[flavor_id]"
		fill_in "batch[gallons]", with: 25

		click_button "Update Batch"

		expect(page).to have_content flavor2.abbreviation
		expect(page).to have_content 25
		expect(page).to_not have_content flavor.abbreviation
		expect(page).to_not have_content 15
	end

	scenario "Work with just changing the batch gallons (custom controller function test)" do

		fill_in "batch[gallons]", with: 30

		click_button "Update Batch"

		expect(page).to have_content flavor.abbreviation
		expect(page).to have_content 30
	end

	scenario "fails if gallons is changed to below the allowable limit of 10" do

		fill_in "batch[gallons]", with: 9

		click_button "Update Batch"

		expect(page).to have_content "The batch was not changed"
		expect(page).to have_content "A batch must be at least 10 gallons"
	end

	scenario "fails if gallons is changed to above the allowable limit of 42" do

		fill_in "batch[gallons]", with: 43

		click_button "Update Batch"

		expect(page).to have_content "The batch was not changed"
		expect(page).to have_content "A batch can not exceed 42 gallons"
	end

	scenario "fails if gallons is changed to be blank" do

		fill_in "batch[gallons]", with: ""

		click_button "Update Batch"

		expect(page).to have_content "The batch was not changed"
		expect(page).to have_content "Gallons can't be blank"
	end

	scenario "fails if gallons is changed to a non number" do

		fill_in "batch[gallons]", with: "a"

		click_button "Update Batch" 

		expect(page).to have_content "The batch was not changed"
		expect(page).to have_content "Gallons is not a number"
	end
end