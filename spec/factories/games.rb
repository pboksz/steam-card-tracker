# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    sequence(:name) { |n| "Game#{n}" }
    price_per_badge 0.99
  end
end
