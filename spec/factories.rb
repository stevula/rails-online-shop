FactoryGirl.define do
  factory :product do
    name        Faker::Commerce.product_name
    description Faker::Company.bs
    price       Faker::Commerce.price
    quantity    Faker::Number.between(0, 20)
  end
end
