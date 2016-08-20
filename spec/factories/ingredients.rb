FactoryGirl.define do
  factory :ingredient do
    sequence(:name, "aa") {|n| "Ingredient Name#{n}"}
  end

end
