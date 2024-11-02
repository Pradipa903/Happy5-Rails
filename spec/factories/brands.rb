FactoryBot.define do
  factory :brand do
    brand_name { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
  end
end