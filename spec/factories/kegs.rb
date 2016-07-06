FactoryGirl.define do
	factory :keg do
		sequence(:serial_number, 10) { |n| "16-2345#{n}B" }
	end
end