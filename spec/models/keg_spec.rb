require 'rails_helper'

RSpec.describe Keg, type: :model do

	scenario "The default status should be 0" do
		keg = FactoryGirl.build(:keg)
		expect(keg.status).to eq "empty"
	end

	scenario "The default status of 0 should return true for .empty?" do

		keg = FactoryGirl.build(:keg)
		expect(keg.empty?).to eq true
	end
end
