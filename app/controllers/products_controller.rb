class ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find( params[:id] )
  end

  def buy
    # 加入購物車
    @product = Product.find( params[:id] )

    line_item = @current_cart.line_items.find_by( :product_id => @product.id )
    if line_item
      line_item.qty = line_item.qty + 1
      line_item.save!
    else
      @current_cart.line_items.create!( :product => @product, :qty => 1 )
    end

    flash[:notice] = "加入成功"
    redirect_to :back
  end

  def cancel
    @product = Product.find( params[:id] )

    line_item = @current_cart.line_items.find_by( :product_id => @product.id )
    line_item.destroy

    flash[:notice] = "移除成功"
    redirect_to :back
  end

end
