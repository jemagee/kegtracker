FactoryGirl.define do
  factory :flavor do
    sequence(:name, "a")  {|n| "Factory Flavor Name#{n}"}
    abbreviation {random_abbreviation}
    gpg 250
  end
end
  def random_abbreviation
  	('A'..'Z').to_a.shuffle.join[0..3]
  end