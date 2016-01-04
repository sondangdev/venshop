class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_cart
    return current_user.current_cart if user_signed_in?
    cart = Cart.find(session[:cart_id])
  rescue
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
