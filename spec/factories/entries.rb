FactoryGirl.define do
  factory :entry do
    sequence(:name) {|n| "entry_name_#{n}"}
    priority 1
    user
  end
end
