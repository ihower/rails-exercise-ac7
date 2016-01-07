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

    current_cart.add_line_item(@product)

    flash[:notice] = "加入成功"
    redirect_to :back
  end

  def cancel
    @product = Product.find( params[:id] )

    line_item = current_cart.line_items.find_by( :product_id => @product.id )
    line_item.destroy

    flash[:notice] = "移除成功"
    redirect_to :back
  end

end
