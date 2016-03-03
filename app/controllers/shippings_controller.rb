class ShippingsController < ApplicationController
  def get_shipping_price
    shipping = Shipping.find(params[:id])
    render json: { price: shipping.price, status: :ok }
  end
end
