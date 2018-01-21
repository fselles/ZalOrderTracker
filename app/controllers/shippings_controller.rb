class ShippingsController < ApplicationController
before_action :require_signin

  def create
    @order = Order.find(params[:order_id])
    @shipping = @order.shippings.create(params[:shipping].permit(:carrier, :packaging_details, :shipping_data_url, :shipping_date))
  end

end


