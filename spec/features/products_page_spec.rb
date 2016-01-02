require 'rails_helper'

RSpec.feature "Products Page", type: :feature do
  let!(:existing_product) {FactoryGirl.create(:product, quantity: 3, price: 5.0)}
  describe "when there is no user logged in" do
    scenario "should display the correct price" do
      visit products_path
      expect(page).to have_css("#product_#{existing_product.id}",:text => 5.0)
    end
  end

  describe "when an admin is logged in" do
    before(:each) do
      user = FactoryGirl.create(:user,:admin)
      sign_in(user)
      visit products_path
    end

    scenario "should display a create new product button" do
      expect(page).to have_css(".btn", :text => "Create New Product")
    end

    scenario "should display the correct quantity" do
      expect(page).to have_css("#product_#{existing_product.id}",:text => 3)
    end
  end

end
