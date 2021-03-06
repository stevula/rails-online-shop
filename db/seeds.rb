# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
20.times do
  Product.create(
    name:        Faker::Commerce.product_name,
    description: Faker::Company.bs,
    price:       Faker::Commerce.price,
    quantity:    Faker::Number.between(0, 20)
    )
end

FactoryGirl.create(:user, :admin)
FactoryGirl.create(:user, :non_admin)
