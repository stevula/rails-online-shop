require 'rails_helper'

RSpec.feature "Products Page", type: :feature do
  let!(:existing_product) {FactoryGirl.create(:product, quantity: 3, price: 5.0)}
  describe "when there is no user logged in" do
    scenario "should display the correct quantity" do
      visit products_path
      expect(page).to have_css('li',:text => 3)
    end

    scenario "should display the correct price" do
      visit products_path
      expect(page).to have_css("#product_#{existing_product.id}",:text => 5.0)
    end
  end
  describe "when an user is logged in" do
   scenario "should display a create new product button" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit products_path
    expect(page).to have_css(".btn", :text => "Create New Product")
    end
  end

end
