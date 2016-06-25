require 'rails_helper'

RSpec.feature "Testing Edit User functionality" do

  let!(:user) {FactoryGirl.create(:user)}

  before do
    login_as user
    visit edit_user_registration_path(user)
  end

  scenario "You should be able to alter the first and last name fields" do

    fill_in "First Name", with: "Roland"
    fill_in "Last Name", with: "Mageggle"
    fill_in "Current password", with: user.password
    click_button "Update" 

    expect(page).to have_content("Your account has been updated successfully")
    user.reload
    expect(user.fname).to eq "Roland"
    expect(user.lname).to eq "Mageggle"
  end
end