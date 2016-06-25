FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testemail#{n}@teeccicno.com" }
    password "password"
    fname "John"
    lname "Magee"
  end

end
