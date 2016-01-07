require 'rails_helper'

RSpec.describe Cart, type: :model do

  before do
    @cart = Cart.create!
    @product = Product.create!( :name => "foobar", :price => 500 )
    @product2 = Product.create!( :name => "foobar2", :price => 200 )

  end

  describe "#add_line_item" do
    it "should create new line_item" do

      @cart.add_line_item( @product )

      line_item = LineItem.last

      expect( line_item.product ).to eq( @product )
      expect( line_item.qty ).to eq(1)
      expect( line_item.cart ).to eq(@cart)
    end

    it "should increase qty for existing line_item" do
      @cart.add_line_item( @product )
      @cart.add_line_item( @product )
      @cart.add_line_item( @product )

      @cart.add_line_item( @product2 )

      line_item = LineItem.first
      expect( line_item.qty ).to eq(3)
      expect( LineItem.count ).to eq(2)      
    end

  end

end
