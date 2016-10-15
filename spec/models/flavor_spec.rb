require 'rails_helper'

RSpec.describe Flavor, type: :model do
  let!(:flavor) {FactoryGirl.create(:flavor)}
  let!(:flavor2) {FactoryGirl.create(:flavor)}
  let!(:ingredient) {FactoryGirl.create(:ingredient)}
  let!(:ingredient2) {FactoryGirl.create(:ingredient)}
  let!(:component) {FactoryGirl.create(:component, flavor: flavor2, ingredient: ingredient, percentage: 25)}
  let!(:component1) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient, percentage: 15)}
  let!(:component2) {FactoryGirl.create(:component, flavor: flavor2, ingredient: ingredient2, percentage: 75)}

  it { should validate_uniqueness_of(:name).case_insensitive.with_message("This flavor name is already in the system") }
  it { should validate_uniqueness_of(:abbreviation).case_insensitive.with_message("This abbreviation is already in use")}

  it "should have a default archive as false" do
    expect(flavor.archive).to be(false)
  end

  it "should only have valid flavors for batch creation" do
    expect(Flavor.batch_eligible.length).to eq 1
    expect(Flavor.batch_eligible.first).to eq flavor2
  end

  it "should return components in the descending order of percentage" do
    expect(flavor2.components.first.ingredient).to eq ingredient2
  end
end