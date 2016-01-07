FactoryGirl.define do
  factory :endpoint do
    name Faker.name
    recipients "#{Faker::Internet.email}, #{Faker::Internet.email}"
  end
end
