class Topic < ActiveRecord::Base

  validates_presence_of :title, :content

  has_many :comments
  belongs_to :user

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  has_many :subscriptions, :dependent => :destroy
  has_many :subscribed_users, :through => :subscriptions, :source => :user

  has_many :taggings
  has_many :tags, :through => :taggings

  belongs_to :category
  has_many :groupships
  has_many :groups, :through => :groupships
  
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def tag_list
    self.tags.map{ |t| t.name }.join(",")
  end

  def tag_list=(str)
    ids = str.split(",").map do |tag_name|
      tag_name = tag_name.strip.downcase
      tag = Tag.find_by_name( tag_name ) || Tag.create( :name => tag_name )
      tag.id
    end

    self.tag_ids = ids
  end

  def find_my_subscription(u)
    if u
      self.subscriptions.where( :user_id => u.id ).first
    else
      nil
    end
  end

  def find_my_like(u)
    if u
      self.likes.where( :user_id => u.id ).first
    else
      nil
    end
  end

end
