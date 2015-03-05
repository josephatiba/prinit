class ChargesController < ApplicationController
  def new
    @order = current_order
    
    total_amount=0
    @order.order_items.each do |order_item|
      total_amount = total_amount + ((order_item.unit_price * order_item.quantity) + (order_item.quantity*order_item.shipping_cost))

    end

    @order.total= (total_amount.round(2) *100)
    # set order stauts to 2 (paid)
    @order.order_status_id = 2
    @order.save
    # 

  end

  def create
    # Amount in cents
    
    @order = current_order
    @user = current_user
    @amount = @order.total.to_i

    customer = Stripe::Customer.create(
      :email => @user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Prinit',
      :currency    => 'usd'
    )
    # @order.stripe_id = charge.id
    # @order.order_date = Time.new
    # @order.save
    # puts " ***************** charge"
    # puts charge.id

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to cart_path
    end
    session[:order_id] = nil
end
