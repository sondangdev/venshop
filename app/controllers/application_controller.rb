class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_cart
    cart = Cart.find(session[:id])
  rescue
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
