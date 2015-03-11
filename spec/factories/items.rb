# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    game

    name 'Item Name'
    link_url 'http://game.com/link'
    image_url 'http://game.com/item'
  end
end
