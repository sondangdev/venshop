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
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.order_number = SecureRandom.hex.upcase
    @order.add_line_items_from_cart(current_cart)

    if @order.save
      current_user.update_attributes(address: @order.address) if current_user.address.nil?
      current_user.update_attributes(contact_number: @order.contact_number) if current_user.contact_number.nil?
      Cart.destroy(current_cart)
      OrderMailer.order_received(@order).deliver
      redirect_to order_url(@order)
    else
      @cart = current_cart
      add_breadcrumb "New order"
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

  def index
    add_breadcrumb "Your orders"
    @orders = Order.where(user_id: current_user)
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_number, :name, :address, :contact_number, :email, :pay_type, :user_id)
  end
end