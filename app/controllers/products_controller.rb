class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit

  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      @errors = @product.errors.full_messages
      render :new
    end
  end

  def new
    @product = Product.new
  end

  def update
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end
end
