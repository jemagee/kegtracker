require 'rails_helper'

RSpec.describe Keg, type: :model do

	scenario "The default status should be 0" do

		keg = FactoryGirl.build(:keg)
		expect(keg.status).to eq 0
	end
end
