FactoryBot.define do
  factory :game do
    sequence(:name) { |n| "Game#{n}" }
    price_per_badge { 0.99 }
  end
end
