class Topic < ActiveRecord::Base

  validates_presence_of :title, :content

  has_many :comments
  belongs_to :user

  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user

  has_many :subscriptions
  has_many :subscribed_users, :through => :subscriptions, :source => :user

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def find_my_like(u)
    if u
      self.likes.where( :user_id => u.id ).first
    else
      nil
    end
  end

end
