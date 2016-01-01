class ShoppingCartsController < ApplicationController
  def update
    product_id = params[:shopping_cart][:product_id]
    shopping_cart = current_user.shopping_cart
    shopping_cart.products << Product.find(product_id)
    shopping_cart.save
    redirect_to products_path
  end
end

