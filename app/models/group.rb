class Group < ActiveRecord::Base

  has_many :groupships
  has_many :topics, :through => :groupships

end
