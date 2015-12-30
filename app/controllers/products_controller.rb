class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(id: params[:id])
  end

  def edit
    if user_signed_in?
      @product = Product.find(params[:id])
    else
      redirect_to products_path
    end
  end

  def create
    if user_signed_in?
      @product = Product.new(product_params)
      if @product.save
        redirect_to products_path
      else
        render :new
      end
    else
      redirect_to products_path
    end
  end

  def new
    if user_signed_in?
      @product = Product.new
    else
      redirect_to products_path
    end
  end

  def update
    if user_signed_in?
      @product = Product.find(params[:id])
      @product.assign_attributes(product_params)
      if @product.save
        redirect_to @product
      else
        render :edit
      end
    else
      redirect_to products_path
    end
  end

  def destroy
    if user_signed_in?
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to products_path
    else
      redirect_to products_path
    end
  end

  private
  # method to pull out product attributes
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end
end
