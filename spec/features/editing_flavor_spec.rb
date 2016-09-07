require 'rails_helper'

RSpec.feature "Editing a Flavor" do

  let!(:flavor) {FactoryGirl.create(:flavor)}
  let!(:flavor2) {FactoryGirl.create(:flavor)}

  before do
    visit flavor_path(flavor)
    click_link "Edit Flavor"
  end

  scenario "Proper Editing" do

    fill_in "flavor[name]", with: "New Flavor Name"
    fill_in "flavor[abbreviation]", with: "ZZzZ"
    fill_in "flavor[gpg]", with: 150
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

  scenario "Bad Flavor abbreviation" do
    fill_in "flavor[abbreviation]", with: "GDNGHDJ"
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("four letters only")
  end

  scenario "Using an existing abbreviation" do
    fill_in "flavor[abbreviation]", with: flavor2.abbreviation
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("already in use")
  end

  scenario "Using an existing flavor name" do
    fill_in "flavor[name]", with: flavor2.name
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("flavor name is already in the system")
  end

  scenario "Using a blank flavor name" do

    fill_in "flavor[name]", with: ""
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("can't be blank")
  end

  scenario "Using a blank abbreviation" do

    fill_in "flavor[abbreviation]", with: ""
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("can't be blank")
  end

  scenario "Using a grams per gallon below limit" do

    fill_in "flavor[gpg]", with: 59
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("at least 60")
  end

  scenario "Using grams per gallon above limit" do
    fill_in "flavor[gpg]", with: 501
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was not updated")
    expect(page).to have_content("no greater than 500")
  end

  scenario "Blanking out the grams per gallon" do
    fill_in "flavor[gpg]", with: ""
    click_button "Update Flavor"

    expect(page).to have_content("The flavor was updated")
    expect(page).to have_content(flavor.name)
    expect(page).to have_content(flavor.abbreviation.upcase)
  end
end