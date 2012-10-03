FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "name_#{n}"}
    sequence(:login) {|n| "login_#{n}"}
    password "123456"
    password_confirmation { |u| u.password }
  end
end
