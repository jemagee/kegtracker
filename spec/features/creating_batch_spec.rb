require 'rails_helper'

RSpec.feature "Creating a new batch" do

  4.times do |n|
    let!("flavor#{n}".to_s) {FactoryGirl.create(:flavor)}
  end

  let(:ingredient) {FactoryGirl.create(:ingredient)}

  let!(:date) {Date.today.strftime("%m%d%y")}

  before do
    FactoryGirl.create(:component, flavor: flavor0, ingredient: ingredient, percentage: 100)
    FactoryGirl.create(:component, flavor: flavor1, ingredient: ingredient, percentage: 100)
    FactoryGirl.create(:component, flavor: flavor2, ingredient: ingredient, percentage: 100)
    FactoryGirl.create(:component, flavor: flavor3, ingredient: ingredient, percentage: 100)
  end

  scenario "Successfully creating the batch" do
    visit new_batch_path

    fill_in "batch[gallons]", with: 15
    select flavor3.name, from: "batch[flavor_id]"

    click_button "Create Batch"

    expect(page).to have_content("The batch was created")
    expect(page).to have_content("#{flavor3.abbreviation}-#{flavor3.created_at.strftime("%m%d%y")}-A")
    expect(page).to have_content("Best By Date: #{(Date.today + 90.days).strftime("%m/%d/%y")}")
  end

  context "requires a valid entry of gallons" do

    before do
      visit new_batch_path
      select flavor2.name, from: "batch[flavor_id]"
    end

    scenario "gallons can't be blank" do

      click_button "Create Batch"

      expect(page).to have_content("The batch was not created")
      expect(page).to have_content("Gallons can't be blank")
      expect(page).to_not have_content("#{flavor2.abbreviation}-#{flavor2.created_at.strftime("%m%d%y")}-A")
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

  scenario "rquires a selection of a valid flavor" do

    visit new_batch_path
    fill_in "batch[gallons]", with: 25
    click_button "Create Batch"

    expect(page).to have_content("The batch was not created")
    expect(page).to have_content("You must select a valid flavor to create a batch")
  end

  context "Testing the automated lot creation functionality" do
      let!(:batch_one) {Batch.create(flavor_id: flavor1.id, gallons:20 )}

    before do 
      visit new_batch_path
    end

    scenario "The second lot number is generated properly." do

      select flavor1.name, from: "batch[flavor_id]"
      fill_in "batch[gallons]", with: 12

      click_button "Create Batch"

      expect(page).to have_content("The batch was created")
      expect(page).to_not have_content(batch_one.lot)
      expect(page).to have_content("#{flavor1.abbreviation}-#{flavor1.created_at.strftime("%m%d%y")}-B")
    end
  end

  scenario "from a flavor page works as well" do
    visit flavor_path(flavor1)

    click_link "Create Batch From #{flavor1.name}"

    fill_in "batch[gallons]", with: 40

    click_button "Create Batch"
    expect(page).to have_content("The batch was created")
    expect(page).to have_content(flavor1.name)
    expect(page).to have_content(flavor1.abbreviation)
  end

  scenario "from a flavor page with a 'full load' (42 gallons) works as well" do

    visit flavor_path(flavor3)

    click_link "Create FULL Batch from #{flavor3.name}"

    expect(page).to have_content("The batch was created")
    expect(page).to have_content(flavor3.name)
    expect(page).to have_content(flavor3 .abbreviation)
  end
end