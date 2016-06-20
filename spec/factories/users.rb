FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testemail#{n}@teeccicno.com" }
    password "password"
  end

end
