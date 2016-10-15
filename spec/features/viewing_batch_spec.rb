require 'rails_helper'

RSpec.feature "Viewing a Batch" do
	let(:flavor) {FactoryGirl.create(:flavor, gpg: 60)}
	let(:ingredient) {FactoryGirl.create(:ingredient)}
	let(:ingredient2) {FactoryGirl.create(:ingredient)}
	let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient, percentage: 90)}
	let!(:component2) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient2, percentage: 10)}
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
		within("div#components") do
			within("div#ingredient_#{ingredient.id}") do
				expect(page).to have_content(component.ingredient.name)
				expect(page).to have_content(component.percentage * flavor.gpg * batch.gallons)
			end
			within("div#ingredient_#{ingredient2.id}") do
				expect(page).to have_content(component2.ingredient.name)
				expect(page).to have_content(component2.percentage * flavor.gpg * batch.gallons)
			end
		end
	end
end