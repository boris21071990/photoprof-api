FactoryBot.define do
  factory :photographer do
    association :user, role: User::ROLE_PHOTOGRAPHER
    association :city

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    description { Faker::Lorem.paragraph(sentence_count: 10) }
    enabled { true }

    trait :reindex do
      after(:create) do |photographer, _evaluator|
        photographer.reindex(refresh: true)
      end
    end
  end
end
