require 'rails_helper'

RSpec.feature "Editing an ingredient" do

  let(:ingredient) { FactoryGirl.create(:ingredient) }
  let(:ingredient2) { FactoryGirl.create(:ingredient) }

  before { visit edit_ingredient_path(ingredient) }

  scenario "works with a valid name" do

    fill_in "Name", with: "New Ingredient Name"

    click_button "Update Ingredient"

    expect(page).to have_content("Ingredient was updated")
    expect(page).to have_content("New Ingredient Name")
    expect(page).to_not have_content(ingredient.name)
  end

  scenario "fails with a blank name" do

    fill_in "Name", with: ""

    click_button "Update Ingredient"

    expect(page).to have_content("Ingredient was not updated")
    expect(page).to have_content("Name can't be blank")
  end

  scenario "fails with a too short name" do

    fill_in "Name", with: "aaa"

    click_button "Update Ingredient"

    expect(page).to have_content("Ingredient was not updated")
    expect(page).to have_content("too short")
    expect(page).to have_content("4 characters")
    expect(page).to_not have_content("aaa")
  end

  scenario "fails with a non-unique (case insensitive) name" do

    fill_in "Name", with: ingredient2.name.upcase

    click_button "Update Ingredient"

    expect(page).to have_content("Ingredient was not updated")
    expect(page).to have_content("This ingredient is already in the database")
    expect(page).to_not have_content(ingredient2.name)
  end
end