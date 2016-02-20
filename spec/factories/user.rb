FactoryGirl.define do
  factory :user do
    name Faker.name
    email Faker::Internet.email
    password '12345678'
  end
end
