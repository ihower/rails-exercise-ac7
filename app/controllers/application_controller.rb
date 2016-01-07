class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cart

  protected

  def set_cart
    if session[:cart_id]
      @current_cart = Cart.find( session[:cart_id] )
    else
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end            
  end

  def set_topic
    @topic = Topic.find( params[:topic_id] )
  end

end
