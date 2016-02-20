FactoryGirl.define do
  factory :contact do
    name Faker.name
    email Faker::Internet.email
  end
end
