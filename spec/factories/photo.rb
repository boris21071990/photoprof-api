FactoryBot.define do
  factory :photo do
    association :photographer
    association :category

    likes_count { 0 }
    enabled { true }
  end
end
