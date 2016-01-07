class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :set_cart

  protected

  def get_cart
    if session[:cart_id]
      cart = Cart.find( session[:cart_id] )
    else
      cart = Cart.create!
      session[:cart_id] = cart.id
    end

    return cart
  end

  def current_cart
    unless @current_cart
      @current_cart = get_cart
    end

    return @current_cart
  end

  helper_method :current_cart

  def set_topic
    @topic = Topic.find( params[:topic_id] )
  end

end
