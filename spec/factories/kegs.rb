FactoryGirl.define do
	factory :keg do
		sequence(:serial_number) { |n| "16-23451#{n}B" }
	end
end