require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before {@ingredient = FactoryGirl.build(:ingredient)}

  it "should have a default archive value of false" do

  	expect(@ingredient.archived).to be(false)
  end
end
