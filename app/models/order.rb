class Order < ActiveRecord::Base

  validates_presence_of :name, :amount

  belongs_to :user
  has_many :line_items

  def add_line_items(cart)
    cart.line_items.each do |line|
      self.line_items.build( :product => line.product, :qty => line.qty )
    end

    self.amount = cart.amount
  end

end
