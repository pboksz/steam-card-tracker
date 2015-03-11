# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stat do
    item

    min_price_low 0.10
    min_price_high 0.20
  end
end
