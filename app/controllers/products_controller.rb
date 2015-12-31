class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    return redirect_to products_path unless user_signed_in? && current_user.admin

    @product = Product.find(params[:id])
  end

  def create
    return redirect_to products_path unless user_signed_in? && current_user.admin

    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def new
    return redirect_to products_path unless user_signed_in? && current_user.admin

    @product = Product.new
  end

  def update
    return redirect_to products_path unless user_signed_in? && current_user.admin

    @product = Product.find(params[:id])
    @product.assign_attributes(product_params)
    if @product.save
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    return redirect_to products_path unless user_signed_in? && current_user.admin

    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private
  # method to pull out product attributes
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end
end
