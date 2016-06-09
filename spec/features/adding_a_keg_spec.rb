require 'rails_helper'

RSpec.feature "Creating Kegs" do

  scenario "Adding a keg" do

    visit new_keg_path

    fill_in "keg[serial_number]", with: "16-123456B"
    click_button "Add Keg"

    expect(page).to have_content("16-123456B")
    within("div.success") do
      expect(page).to have_content("Keg has been added")
    end
  end

  scenario "A serial Number is required" do

    visit new_keg_path

    click_button "Add Keg"

    expect(page).to have_content("Serial number can't be blank")
    within("div.warning") do
      expect(page).to have_content("The keg was not added")
    end
  end

  scenario "A serial number must be unique" do

    Keg.create(serial_number: "16-123456B")
    visit new_keg_path
    fill_in "keg[serial_number]", with: "16-123456B"
    click_button "Add Keg"

    within("div.warning") do
      expect(page).to have_content("The keg was not added")
    end
    expect(page).to have_content("Serial number has already been taken")
  end

  scenario "A serial number must follow the correct formatting" do

    visit new_keg_path
    fill_in "keg[serial_number]", with: "12345"
    click_button "Add Keg"

    within("div.warning") do
      expect(page).to have_content("The keg was not added")
    end
    expect(page).to have_content("Please use a properly formatted serial number")
  end


end
