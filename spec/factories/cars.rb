FactoryBot.define do
  factory :car do
    name { Faker::Movies::StarWars.character }
    car_type { "Sedan" } # Example type, change as needed or replace with your desired default
    release_year { Faker::Number.between(from: 1990, to: 2023) } # Random year between 1990 and 2023
    is_used { true }
    brand_id { nil }
  end
end
