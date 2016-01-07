class PagesController < ApplicationController
  def home
    add_breadcrumb "Home"
    @categories = Category.all
  end
end
