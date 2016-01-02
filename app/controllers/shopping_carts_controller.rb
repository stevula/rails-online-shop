class ShoppingCartsController < ApplicationController
  def update
    product_id = params[:shopping_cart][:product_id]
    shopping_cart = current_user.shopping_cart
    if params[:shopping_cart][:remove]
    shopping_cart.products.delete(Product.find(product_id))
    else
    shopping_cart.products << (Product.find(product_id))
    end
    shopping_cart.save
    redirect_to products_path
  end
  def show
    shopping_cart = current_user.shopping_cart
    @products = shopping_cart.products
  end
  def edit
    @shopping_cart = current_user.shopping_cart
    @products = @shopping_cart.products
  end
  def destroy
    shopping_cart = current_user.shopping_cart
    shopping_cart.products.clear
    shopping_cart.save
    redirect_to edit_user_shopping_cart_path
  end

end

