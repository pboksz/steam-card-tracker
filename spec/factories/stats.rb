FactoryBot.define do
  factory :stat do
    item

    min_price_low { 0.10 }
    min_price_high { 0.20 }
    quantity { 102 }
  end
end
