class OrderMailer < ApplicationMailer
  def order_received(order)
    @order = order
    mail to: order.email, subject: "Your order confirmation"
  end
end
