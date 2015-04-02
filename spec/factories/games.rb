# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    sequence(:name) { |n| "Game#{n}" }
    updated_at Date.today
  end
end
