class Topic < ActiveRecord::Base

  validates_presence_of :title, :content

  has_many :comments
  belongs_to :user

end
