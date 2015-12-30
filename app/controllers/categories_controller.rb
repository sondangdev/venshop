class CategoriesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    @category = Category.friendly.find(params[:id])
    add_breadcrumb @category.title
    @products = @category.products.order(created_at: :desc).page(params[:page])
  end
end
