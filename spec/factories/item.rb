FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Number.within(range: 1..10) }

    association :merchant, factory: :merchant
  end
end
