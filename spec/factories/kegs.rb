FactoryGirl.define do
	factory :keg do
		sequence(:serial_number) {|n| "16-02345#{n}-B"}
	end
end