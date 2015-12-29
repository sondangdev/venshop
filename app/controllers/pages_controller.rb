class PagesController < ApplicationController
  def home
    add_breadcrumb "Home"
  end
end
