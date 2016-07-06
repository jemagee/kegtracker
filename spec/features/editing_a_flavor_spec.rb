require 'rails_helper'

RSpec.feature "Editing a Flavor" do

  let!(:flavor) {FactoryGirl.create(:flavor)}

  before do
    visit flavor_path(flavor)
    click_link "Edit Flavor"
  end

  scenario "Proper Editing" do

    fill_in "flavor[name]", with: "New Flavor Name"
    fill_in "flavor[abbreviation]", with: "ZZzZ"
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was updated")
    expect(page).to have_content("New Flavor Name")
    expect(page).to have_content("ZZZZ")
    expect(page).to_not have_content("ZZzZ")
  end

  scenario "Bad Flavor Name" do
    fill_in "flavor[name]", with: "No"

    click_button "Update Flavor"
    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("The flavor name must be at least 6 characters")
  end
end