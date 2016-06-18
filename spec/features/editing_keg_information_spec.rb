require 'rails_helper'

RSpec.feature "Editing a keg" do
    let!(:keg) { FactoryGirl.create(:keg) }
    let(:kegg) { FactoryGirl.create(:keg) }

    before do 
      visit keg_path(keg) 
      click_link "Edit Keg"
    end

    scenario "Changing the Keg Serial Number Is Successful" do

      fill_in "keg[serial_number]", with: "16-758406B"
      click_button "Update Keg"

      expect(page).to have_content("The keg was updated successfully")
      expect(page).to_not have_content(keg.serial_number)
      expect(page).to have_content("16-758406B")
    end

    scenario "Changing to an empty serial number" do

      fill_in "keg[serial_number]", with: "" 
      click_button "Update Keg"

      expect(page).to have_content("The keg was not updated")
      expect(page).to have_content("Serial number can't be blank")
      expect(page).to_not have_content(keg.serial_number)
    end

    scenario "Changing to a wrong formatted serial number" do

      fill_in "keg[serial_number]", with: "16545434B"
      click_button "Update Keg"

      expect(page).to have_content("The keg was not updated")
      expect(page).to have_content("Please use a properly formatted serial number")
    end

    scenario "Changing to an already existing serial number" do

      fill_in "keg[serial_number]", with: kegg.serial_number
      click_button "Update Keg"

      expect(page).to have_content("The keg was not updated")
      expect(page).to have_content("This serial number is already in use with another keg")
    end
end
