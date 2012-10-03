FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "name_#{n}"}
    password "123456"
    login "apotema"
  end
end
