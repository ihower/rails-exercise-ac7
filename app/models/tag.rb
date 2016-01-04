class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :topics, :through => :taggings

end
