require 'rails_helper'

RSpec.feature "Creating a new batch" do

  4.times do |n|
    let!("flavor#{n}".to_s) {FactoryGirl.create(:flavor)}
  end

  let!(:date) {Date.today.strftime("%m%d%y")}

  scenario "Successfully creating the batch" do
    visit new_batch_path

    fill_in "batch[gallons]", with: 15
    select flavor3.name, from: "batch[flavor_id]"

    click_button "Create Batch"

    expect(page).to have_content("The batch was created")
    expect(page).to have_content("#{flavor3.abbreviation}-#{flavor3.created_at.strftime("%m%d%y")}-A")
  end

  context "Testing validation of the gallons entry" do

    before do
      visit new_batch_path
      select flavor2.name, from: "batch[flavor_id]"
    end

    scenario "gallons can't be blank" do

      click_button "Create Batch"

      expect(page).to have_content("The batch was not created")
      expect(page).to have_content("Gallons can't be blank")
      expect(page).to_not have_content("#{flavor2.name}-#{flavor2.created_at.strftime("%m%d%y")}-A")
    end

    scenario "gallons must be a number" do

      fill_in "batch[gallons]", with: "abcdef"
      click_button "Create Batch"

      expect(page).to have_content("The batch was not created")
      expect(page).to have_content("Gallons is not a number")
    end


    scenario "must make at least 10 gallons" do

      fill_in "batch[gallons]", with: 9
      click_button "Create Batch"

      expect(page).to have_content("The batch was not created")
      expect(page).to have_content("A batch must be at least 10 gallons")
    end

    scenario "must make no more than 42 gallons" do

      fill_in "batch[gallons]", with: 43
      click_button "Create Batch"

      expect(page).to have_content("The batch was not created")
      expect(page).to have_content("A batch can not exceed 42 gallons")
    end
  end
end