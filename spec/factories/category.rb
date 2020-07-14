FactoryBot.define do
  factory :category do
    name { ["Wedding", "Portrait", "Real Estate"].sample }
  end
end
