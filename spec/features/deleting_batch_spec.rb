require 'rails_helper'

RSpec.feature "Deleting a batch" do

	let!(:flavor) {FactoryGirl.create(:flavor)}
	let(:batch) {FactoryGirl.create(:batch, flavor: flavor)}

	before {visit batch_path(batch)}

	scenario "works" do

		click_link "Delete Batch"

		expect(page).to have_content("The batch has been deleted")
		expect(current_path).to eq root_path
	end


end
