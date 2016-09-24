require 'rails_helper'

RSpec.feature "Viewing all and individual kegs" do
	let!(:keg) { FactoryGirl.create(:keg) }
	let!(:kegg) { FactoryGirl.create(:keg, status: "Consigned") }

	before { visit kegs_path }

	scenario "Kegs are listed on the index page" do

		expect(page).to have_link(keg.serial_number)
		expect(page).to have_link(kegg.serial_number)
	end

	scenario "Clicking on the link for kegg gets kegg" do

		click_link kegg.serial_number

		expect(page).to have_content(kegg.serial_number)
		within("div.status") do
			expect(page).to have_content("Consigned")
			expect(page).to_not have_content("Empty")
		end
		within("div.location") do 
			expect(page).to have_content("Teeccino Warehouse")
		end
	end
end