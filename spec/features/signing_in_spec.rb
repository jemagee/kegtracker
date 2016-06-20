require 'rails_helper'

RSpec.feature "Signing into the site" do

	let!(:user) { FactoryGirl.create(:user)}

	scenario "Signing in works" do

		visit new_user_session_path

		fill_in "Email", with: user.email
		fill_in "Password", with: user.password

		click_button "Log in"

		expect(page).to have_content("Signed in successfully")
		expect(current_path).to eq root_path
	end
end