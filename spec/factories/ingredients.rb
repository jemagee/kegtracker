FactoryGirl.define do
  factory :ingredient do
    sequence(:name, "a") {|n| "Ingredient Name#{n}"}
  end

end
