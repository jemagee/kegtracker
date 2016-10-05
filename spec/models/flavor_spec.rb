require 'rails_helper'

RSpec.describe Flavor, type: :model do
  let!(:flavor) {FactoryGirl.create(:flavor)}
  let!(:flavor2) {FactoryGirl.create(:flavor)}
  let!(:ingredient) {FactoryGirl.create(:ingredient)}
  let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient, percentage: 25)}
  let!(:component1) {FactoryGirl.create(:component, flavor: flavor2, ingredient: ingredient, percentage: 100)}

  it "should have a default archive as false" do
    expect(flavor.archive).to be(false)
  end

  it "should only have valid flavors for batch creation" do
    expect(Flavor.batch_eligible.length).to eq 1
    expect(Flavor.batch_eligible.first).to eq flavor2
  end
end