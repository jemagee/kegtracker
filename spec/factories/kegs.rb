FactoryGirl.define do
	factory :keg do
    serial_number {keg_number}
	end
end

  def keg_number
    x = (100000..999999).to_a.shuffle[0]
    "16-#{x}B"
  end