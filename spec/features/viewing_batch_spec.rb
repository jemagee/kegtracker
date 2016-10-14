require 'rails_helper'

RSpec.feature "Viewing a Batch" do

	let(:flavor) {FactoryGirl.create(:flavor)}
	let(:ingredient) {FactoryGirl.create(:ingredient)}
	let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient, percentage: 100)}
	let!(:batch) {FactoryGirl.create(:batch, flavor: flavor)}
	let!(:batch1) {FactoryGirl.create(:batch, flavor: flavor)}

	before {visit batches_path}

	scenario "Works from the batches page" do

		within("div#batch_#{batch.id}") do
			click_link batch.lot
		end

		expect(page).to have_content(batch.lot)
		expect(page).to have_content(flavor.name)
		expect(page).to_not have_content(batch1.lot)
	end
end