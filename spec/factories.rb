FactoryGirl.define do
  factory :product do
    name        Faker::Commerce.product_name
    description Faker::Company.bs
    price       Faker::Commerce.price
    quantity    Faker::Number.between(0, 20)
  end

  factory :user do
    trait :non_admin do
      email 'test@example.com'
      password '12345678'
    end

    trait :admin do
      email 'admin@example.com'
      password '12345678'
      admin true
    end
  end
end
