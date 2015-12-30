require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product_no_name) {Product.new(description:"I am a description", price:100, quantity:10)}
  let(:product_no_description) {Product.new(name: "Bob", price:100, quantity:10)}
  let(:product_no_price) {Product.new(name: "Bob", description:"I am a description", quantity:10)}
  let(:product_no_quantity) {Product.new(name: "Bob", description:"I am a description", price:100)}
  let(:product_no_numbers) {Product.new(name: "Bob", description:"I am a description", price: "Bob", quantity: "broken")}
  let(:product) {Product.new(name: "Bob", description:"I am a description", price: 100, quantity: 50)}
  describe 'validations' do
    context "it will raise an error" do
      it "when the name is empty" do
        product_no_name.save
        expect(product_no_name.errors[:name]).to include("can't be blank")
      end
      it "when the description is empty" do
        product_no_description.save
        expect(product_no_description.errors[:description]).to include("can't be blank")
      end
      it "when the price is empty" do
        product_no_price.save
        expect(product_no_price.errors[:price]).to include("can't be blank")
      end
      it "when the quantity is empty" do
        product_no_quantity.save
        expect(product_no_quantity.errors[:quantity]).to include("can't be blank")
      end
      it "when the price is not a number" do
        product_no_numbers.save
        expect(product_no_numbers.errors[:price]).to include("is not a number")
      end
      it "when the quantity is not a number" do
        product_no_numbers.save
        expect(product_no_numbers.errors[:quantity]).to include("is not a number")
      end
    end
    context "it will sucessfully save"  do
      it "when all fields are valid" do
        expect{product.save}.to change{Product.count}.by(1)
      end
    end
  end
end
