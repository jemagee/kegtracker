require 'rails_helper'

RSpec.feature "Viewing a flavor" do

	let!(:flavor) {FactoryGirl.create(:flavor)}
	let!(:flavor1) {FactoryGirl.create(:flavor)}


	scenario "works from the flavor index page" do

		visit flavors_path

		within("div#flavor_#{flavor.id}") {click_link "Flavor Detail"}

		expect(page).to have_content(flavor.name)
		expect(page).to have_content(flavor.abbreviation)
		expect(page).to_not have_content(flavor1.name)
	end
end