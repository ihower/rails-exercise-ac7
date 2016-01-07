class Order < ActiveRecord::Base

  validates_presence_of :name, :amount
  
  belongs_to :user
  has_many :line_items

end
