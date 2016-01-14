class UsersController < ApplicationController
  before_action :authenticate_admin!, only: :index
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "All users"
    @users = User.all.page(params[:page])
  end
end
