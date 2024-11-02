FactoryBot.define do
  factory :car do
    name { Faker::StarWars.character }
    type { "Sedan" } # Example type, change as needed or replace with your desired default
    release_year { Faker::Number.between(from: 1990, to: 2023) } # Random year between 1990 and 2023
    is_used { false }
    brand_id { nil }
  end
end
