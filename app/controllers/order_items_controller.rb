class OrderItemsController < ApplicationController
    before_action :authorize, only: [:create, :update, :destroy]

   def create
    if !logged_in?
      @order = current_order
      @order_item = @order.order_items.new(order_item_params)
      @order.save
      if @order.save
         @order_item.save
          session[:order_id] = @order.id.to_s
      end
    else
      redirect_to login_path
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to posts_path
  end
private

  def order_item_params
    params.require(:order_item).permit(:quantity, :post_id, :file_url, :variant_id)
  end

  def authorize
    if @order_item.order.user != current_user
      redirect_to login_path
    end
  end
end
