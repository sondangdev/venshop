class CartsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def create
  end

  def show
    add_breadcrumb "Your cart"
    @cart = current_cart
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to access invalid cart"
    redirect_to products_url, notice: "Invalid cart"
  else
    respond_to do |format|
      format.html
      format.xml { render :xml => @cart }
    end
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Your cart is currently empty" }
      format.xml { head :ok }
    end
  end

end
