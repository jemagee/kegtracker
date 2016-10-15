require 'rails_helper'

RSpec.describe Component, type: :model do
  let(:flavor) {FactoryGirl.create(:flavor, gpg: 100)}
  let(:ingredient) {FactoryGirl.create(:ingredient)}
  let(:ingredient2) {FactoryGirl.create(:ingredient)}
  let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient, percentage: 25)}
  let!(:component2) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient2, percentage: 75)}

  it "should sort by percentage in descending order by default" do
  	expect(Component.all.first).to eq component2
  end
end
