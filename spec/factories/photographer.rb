FactoryBot.define do
  factory :photographer do
    association :user
    association :city

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    description { Faker::Lorem.paragraph(sentence_count: 10) }
    enabled { true }
  end
end
