class CategoriesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    @category = Category.find(params[:id])
    add_breadcrumb @category.title
    @products = Product.where(category_id: params[:id]).order(created_at: :desc).page(params[:page])
  end
end
