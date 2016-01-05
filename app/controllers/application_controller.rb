class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_cart
    return current_user.personal_cart if user_signed_in?
    cart = Cart.find(session[:cart_id])
  rescue
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def combine_cart
    return current_cart if session[:cart_id].nil?
    session_cart = Cart.find(session[:cart_id])

    session_cart.line_items.each do |item|
      current_user.personal_cart.add_product(item.product_id).save
    end

    session_cart.destroy
  end

end
