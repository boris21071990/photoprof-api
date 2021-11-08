FactoryBot.define do
  factory :photo do
    association :photographer
    association :category

    likes_count { 0 }
    enabled { true }

    trait :reindex do
      after(:create) do |photo, _evaluator|
        photo.reindex(refresh: true)
        photo.photographer.reindex(refresh: true)
      end
    end
  end
end
