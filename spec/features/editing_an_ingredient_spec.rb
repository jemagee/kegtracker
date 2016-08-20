require 'rails_helper'

RSpec.feature "Editing an ingredient" do

  let(:ingredient) { FactoryGirl.create(:ingredient) }
  let(:ingredient2) { FactoryGirl.create(:ingredient) }

  scenario "works with a valid name" do

    visit edit_ingredient_path(ingredient)

    fill_in "Name", with: "New Ingredient Name"

    click_button "Update Ingredient"

    expect(page).to have_content("Ingredient was updated")
    expect(page).to have_content("New Ingredient Name")
    expect(page).to_not have_content(ingredient.name)
  end
end