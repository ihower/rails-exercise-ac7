require 'rails_helper'

RSpec.describe Topic, :type => :model do

  describe "#tag_list" do

    it "should return tag list" do
      topic = Topic.create!( :title => "foo", :content => "qq")

      t1 = Tag.create!( :name => "ruby" )
      t2 = Tag.create!( :name => "css" )
      topic.tags = [t1,t2]

      expect( topic.tag_list ).to eq("ruby,css")
    end

  end

end
