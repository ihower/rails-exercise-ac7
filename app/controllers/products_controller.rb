class ProductsController < ApplicationController

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    @products = @products.page(params[:page])
  end

  def show
    @product = Product.find( params[:id] )
  end

  def buy
    # 加入購物車
    @product = Product.find( params[:id] )

    current_cart.add_line_item(@product)

    respond_to do |format|
      format.html {
        flash[:notice] = "加入成功"
        redirect_to :back
      }
      format.js
    end
  end

  def cancel
    @product = Product.find( params[:id] )

    line_item = current_cart.line_items.find_by( :product_id => @product.id )
    line_item.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = "移除成功"
        redirect_to :back
      }
      format.js { render "buy" }
    end

  end

end
