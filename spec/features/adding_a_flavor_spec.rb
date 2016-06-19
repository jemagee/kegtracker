require 'rails_helper'

RSpec.feature "Adding a new flavor" do

  before { visit new_flavor_path }

  scenario "Adding a flavor with the information" do


    fill_in "flavor[name]", with: "New Flavor Name"
    fill_in "flavor[abbreviation]", with: "abCd"
    click_button "Create Flavor"

    expect(page).to have_content("Flavor has been added")
    expect(page).to have_content("New Flavor Name")
    expect(page).to have_content("ABCD")
    expect(page).to_not have_content("abCd")
  end

  context "Testing the Flavor Name validations" do

    before { fill_in "flavor[abbreviation]", with: "ABcD"}

    scenario "Flavor Name is not blank" do

      click_button "Create Flavor"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("The flavor was not created")
      expect(page).to_not have_content("ABCD")
    end

    scenario "Flavor Name is at least 6 letters" do

      fill_in "flavor[name]", with: "This "
      click_button "Create Flavor"

      expect(page).to have_content("The flavor was not created")
      expect(page).to_not have_content("ABCD")
      expect(page).to have_content("The flavor name must be at 6 characters (with no numbers)")
    end

    scenario "Flavor name is made up of only letters and spaces" do

      fill_in "flavor[name]", with: "This is the 4th one" 
      click_button "Create Flavor"

      expect(page).to have_content("The flavor was not created")
      expect(page).to_not have_content("ABCD")
      expect(page).to have_content("The flavor name must be at 6 characters (with no numbers)")
    end
  end


  context "Checking Abbeviation validations only" do

      before { fill_in "flavor[name]", with: "New Flavor Name" }

    scenario "Abbreviation is not blank" do
      
      click_button "Create Flavor" 

      expect(page).to have_content("Abbreviation can't be blank")
      expect(page).to have_content("The flavor was not created")
    end

    scenario "Abbreviation is four characters only" do

      fill_in "flavor[abbreviation]", with: "ABC"
      click_button "Create Flavor"

      expect(page).to have_content("The flavor was not created")
      expect(page).to have_content("The flavor abbreviation MUST BE four letters only")
    end

    scenario "Abbreviation is only made up of letters" do

      fill_in "flavor[abbreviation]", with: "1ABC"
      click_button "Create Flavor"

      expect(page).to have_content("The flavor was not created")
      expect(page).to have_content("The flavor abbreviation MUST BE four letters only")
    end
  end

  context "Testing the uniqueness of the entries" do
    let(:flavor) { FactoryGirl.create(:flavor) }

    scenario "The flavor name must be unique" do

      fill_in "flavor[name]", with: flavor.name.upcase
      fill_in "flavor[abbreviation]", with: "abcd"
      click_button "Create Flavor"

      expect(page).to have_content("The flavor was not created")
      expect(page).to have_content("This flavor name is already in the system")
    end

    scenario "The flavor abbreviation must be unique" do

      fill_in "flavor[name]", with: "This is a different flavor name"
      fill_in "flavor[abbreviation]", with: flavor.abbreviation.downcase
      click_button "Create Flavor"

      expect(page).to have_content("The flavor was not created")
      expect(page).to have_content("This abbreviation is already in use")
    end
  end
end