require 'rails_helper'

RSpec.feature "Products Page", type: :feature do
let(:sign_in){
    visit "/users/sign_up"

    fill_in "Email",                 :with => "alindeman@example.com"
    fill_in "Password",              :with => "ilovegrapes"
    fill_in "Password confirmation", :with => "ilovegrapes"

    click_button "Sign up"
}
  let!(:existing_product) {FactoryGirl.create(:product, quantity: 3, price: 5.0)}
  let(:user) {FactoryGirl.create(:user)}
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
    sign_in
    visit products_path
    expect(page).to have_css(".btn", :text => "Create New Product")

    end
  end

end
