class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new

    @order.name = current_user.fullname
    @order.email = current_user.email
  end

  def create
    @order = Order.new( order_params )
    @order.user = current_user

    @order.add_line_items(current_cart)

    if @order.save
      session[:cart_id] = nil
      
      redirect_to orders_path
    else
      render "new"
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email, :address)
  end

end
