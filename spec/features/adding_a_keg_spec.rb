require 'rails_helper'

RSpec.feature "Creating Kegs" do

  before { visit new_keg_path }

  scenario "Adding a keg" do

    fill_in "keg[serial_number]", with: "16-123456B"
    click_button "Create Keg"

    expect(page).to have_content("16-123456B")
    within("div.success") do
      expect(page).to have_content("Keg has been added")
    end
  end

  scenario "A serial Number is required" do

    click_button "Create Keg"

    expect(page).to have_content("Serial number can't be blank")
    within("div.warning") do
      expect(page).to have_content("The keg was not added")
    end
  end

  scenario "A serial number must be unique" do

    Keg.create(serial_number: "16-123456B")
    fill_in "keg[serial_number]", with: "16-123456B"
    click_button "Create Keg"

    within("div.warning") do
      expect(page).to have_content("The keg was not added")
    end
    expect(page).to have_content("This serial number is already in use with another keg")
  end

  scenario "A serial number must follow the correct formatting" do

    fill_in "keg[serial_number]", with: "12345"
    click_button "Create Keg"

    within("div.warning") do
      expect(page).to have_content("The keg was not added")
    end
    expect(page).to have_content("Please use a properly formatted serial number")
  end

  scenario "A keg has its status set to empty by default" do

    fill_in "keg[serial_number]", with: "16-123456B"
    click_button "Create Keg"

    within ("div.status") do
      expect(page).to have_content("Empty")
    end
  end

  scenario "A keg has its location set to Teeccino Warehouse by default" do

    fill_in "keg[serial_number]", with: "16-123456B"
    click_button "Create Keg"

    within ("div.location") do
      expect(page).to have_content("Teeccino Warehouse")
    end
  end
end
