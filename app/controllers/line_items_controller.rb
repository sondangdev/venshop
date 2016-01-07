class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.friendly.find(params[:product_id])
    qty = params[:qty].to_i
    @line_item = @cart.add_product(product.id, qty)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_url, success: "#{product} was successfully added to your cart" }
        format.xml { render :xml => @line_item , status: created, location: line_item }
      else
        format.html { render "products/#{product}" }
        format.xml { render :xml => @line_item.errors, status: unprocessable_entity }
      end
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    qty = params[:qty].to_i

    respond_to do |format|
      if @line_item.update_attributes(quantity: qty)
        format.html { redirect_to cart_url, success: "#{@line_item.product.title} was changed" }
        format.xml { render :xml => @line_item , status: created, location: line_item }
      else
        format.html { redirect_to cart_url, success: "#{@line_item.product.title} was not changed" }
        format.xml { render :xml => @line_item.errors, status: unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.destroy
        format.html { redirect_to cart_url, success: "A product has been removed from your cart" }
      else
        format.html { render 'carts#show' }
      end
    end
  end

end
