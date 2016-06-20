FactoryGirl.define do
	factory :keg do
		sequence(:serial_number) { |n| "16-2345#{n+10}B" }
	end
end