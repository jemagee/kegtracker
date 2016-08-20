require 'rails_helper'

RSpec.feature "Adding an ingredient" do

  let(:ingredient) {FactoryGirl.create(:ingredient)}

  scenario "Doing the basics" do

    visit new_ingredient_path
    fill_in "Name", with: "Test Ingredient"

    click_button "Add Ingredient"

    expect(page).to have_content("The ingredient has been added")
    expect(page).to have_content("Test Ingredient")
  end

  scenario "requires a unique ingredient name, regardless of case" do

    visit new_ingredient_path
    fill_in "Name", with: ingredient.name

    click_button "Add Ingredient"

    expect(page).to have_content("The ingredient was not added")
    expect(page).to have_content("This ingredient is already in the database")
    expect(page).to_not have_content("has been added")
  end
end