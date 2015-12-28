class Comment < ActiveRecord::Base

  validates_presence_of :content

  belongs_to :topic
  belongs_to :user

end
