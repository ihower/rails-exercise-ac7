class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find( params[:id] )
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

      redirect_to order_path(@order)
    else
      render "new"
    end
  end

  def checkout_pay2go
    @order = current_user.orders.find(params[:id])

    if @order.paid?
      redirect_to :back, alert: 'already paid!'
    else
      @payment = Payment.create!( :order => @order,
                                  :payment_method => params[:payment_method] )
      render :layout => false
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email, :address)
  end

end
