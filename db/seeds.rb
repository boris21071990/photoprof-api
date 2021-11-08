# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category_ids = Category.pluck(:id)

unless category_ids.any?
  Category.create([ { name: "Portrait" },
                    { name: "Wedding" },
                    { name: "Travel" },
                    { name: "Real Estate" },
                    { name: "Nature" }])

  category_ids = Category.pluck(:id)
end

city_ids = City.pluck(:id)

unless city_ids.any?
  50.times do
    City.find_or_create_by(name: Faker::Address.city)
  end

  city_ids = City.pluck(:id)
end

10.times do
  user = User.create(email: Faker::Internet.email, password: "123", role: User::ROLE_PHOTOGRAPHER)

  city_id = city_ids.sample

  image = File.open(Rails.root.join("spec/fixtures/files/profile.png"))

  photographer = Photographer.create!(user: user,
                                      city_id: city_id,
                                      first_name: Faker::Name.first_name,
                                      last_name: Faker::Name.last_name,
                                      image: image,
                                      description: Faker::Lorem.paragraph(sentence_count: 10),
                                      enabled: true)

  image.close

  category_id = category_ids.sample

  5.times do
    image = File.open(Rails.root.join("spec/fixtures/files/profile.png"))

    Photo.create!(photographer: photographer,
                  category_id: category_id,
                  image: image,
                  likes_count: 0,
                  enabled: true)

    image.close
  end

  50.times do
    image = File.open(Rails.root.join("spec/fixtures/files/profile.png"))

    Photo.create!(photographer: photographer,
                  category_id: category_ids.sample,
                  image: image,
                  likes_count: 0,
                  enabled: true)

    image.close
  end
end
