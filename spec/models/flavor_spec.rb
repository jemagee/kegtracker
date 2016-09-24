require 'rails_helper'

RSpec.describe Flavor, type: :model do
  before {@flavor = FactoryGirl.build(:flavor)}

  it "should have a default archive as false" do
  	expect(@flavor.archive).to be(false)
  end
end
