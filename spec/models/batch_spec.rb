require 'rails_helper'

RSpec.describe Batch, type: :model do
  let!(:flavor) {FactoryGirl.create(:flavor)}
  let!(:flavor2) {FactoryGirl.create(:flavor)}
  let!(:ingredient) {FactoryGirl.create(:ingredient)}
  let!(:component) {FactoryGirl.create(:component, flavor: flavor, ingredient: ingredient, percentage: 25)}
  let!(:component1) {FactoryGirl.create(:component, flavor: flavor2, ingredient: ingredient, percentage: 100)}

  it "should not allow batch creation of flavor that isn't batch eligible" do
  	expect{Batch.create(flavor: flavor, gallons: 15)}.to change{Batch.count}.by(0)
  end

  it "should allow batch batch creation of a flavor that is batch eleigible" do
  	expect{Batch.create(flavor: flavor2, gallons: 20)}.to change{Batch.count}.by(1)
  end
end
