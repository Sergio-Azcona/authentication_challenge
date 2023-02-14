FactoryBot.define do
  factory :user do
    name { Faker::Music::RockBand.name}
    email { Faker::Internet.email  }
    password_digest { Faker::Music::RockBand.name }
  end
end