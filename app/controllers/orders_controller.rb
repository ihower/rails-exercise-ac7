class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @product = Product.find( params[:product_id] )

    @order.name = current_user.fullname
    @order.email = current_user.email
  end

  def create
    @order = Order.new( order_params )
    @product = Product.find( params[:product_id] )

    @order.user = current_user

    @order.line_items.build( :product => @product, :qty => params[:qty].to_i )
    @order.amount = @product.price * params[:qty].to_i

    if @order.save
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
