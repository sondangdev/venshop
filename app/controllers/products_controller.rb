class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "All"
    @products = Product.order(created_at: :desc).page(params[:page])
  end

  def show
    @category = @product.category
    add_breadcrumb @category.title, categories_path(@category.id)
    add_breadcrumb @product.title
  end

  def new
    add_breadcrumb 'New Product'
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "Product #{@product.title} has been successfully created"
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit
    add_breadcrumb 'Update Product'
  end

  def update
    @product.update_attributes(product_params)

    if @product.save
      flash[:success] = "Product #{@product.title} has been successfully updated"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = "Product #{@product.title} has been successfully deleted"
      redirect_to products_path
    else
      render 'show'
    end

  end

  private

  def product_params
    params.require(:product).permit(:item_id, :title, :description, :price, :category_id, :image, :manufacturer, :publiscation_date)
  end

  def find_product
    @product = Product.friendly.find(params[:id])
  end
end
