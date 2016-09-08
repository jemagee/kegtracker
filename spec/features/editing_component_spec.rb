require 'rails_helper'

RSpec.feature  "Edting a Flavor Component" do

	let(:flavor) {FactoryGirl.create(:flavor)}
	5.times do |n|
		let("ingredient#{n}".to_s) {FactoryGirl.create(:ingrdient)}
	end
	let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient1)}
	let!(:component2) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient2)}
end