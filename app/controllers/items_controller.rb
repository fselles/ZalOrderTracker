class ItemsController < ApplicationController


  def create
    @order = Order.find(params[:order_id])
    @item = @order.items.create(params[:item].permit(:article_number, :article_description :quantity, :price, :hrpdf_url, :item_comments))
  end

end

