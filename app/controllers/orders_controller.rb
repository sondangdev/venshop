class OrdersController < ApplicationController
  before_action :authenticate_user!
  add_breadcrumb "Home", :root_path
  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def new
    add_breadcrumb "New order"

    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_url, alert: "Your cart is empty"
      return
    end

    @order = Order.new
  end

  def create
    @order = Order.new(user_id: current_user.id)
    @order.order_number = SecureRandom.hex
    @order.add_line_items_from_cart(current_cart)

    if @order.save
      Cart.destroy(current_cart)
      redirect_to order_url(@order)
    else
      @cart = current_cart
      render 'new'
    end
  end

  def show
    add_breadcrumb "Your order"
    if current_user
      @order = Order.find(params[:id])
    else
      redirect_to root_path
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:address, :contact_number, :email, :pay_type, :user_id)
  end
end
