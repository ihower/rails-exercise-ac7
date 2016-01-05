require 'rails_helper'

RSpec.describe "Topics", type: :request do

  describe "GET /topics/:id" do
    it "should return topic json" do

      user = User.create!( :email => "test@example.org", :password => "12345678")
      topic = Topic.create!( :title => "foo", :content => "bar", :user => user )

      get "/api/v1/topics/#{topic.id}"

      data = {
          "content" => topic.content,
          "created_at" => topic.created_at.as_json,
          "id" => 2,
          "photo_content_type" => nil,
          "photo_file_name" => nil,
          "photo_file_size" => nil,
          "photo_medium_url" => "http://www.example.com/images/medium/missing.png",
          "photo_original_url" => "http://www.example.com/images/original/missing.png",
          "photo_thumb_url" => "http://www.example.com/images/thumb/missing.png",
          "photo_updated_at" => nil,
          "title" => "foo",
          "updated_at" => topic.updated_at.as_json,
          "user" => {"id"=>1, "display_name"=>"test@example.org", "email"=>"test@example.org"},
          "views_count" => 0
      }

      parsed_json = JSON.parse( response.body )
      expect(parsed_json).to eq(data)
    end
  end

  describe "POST /topics" do
    it "should save successfully" do
      post "/api/v1/topics", :title => "AAA", :content => "BBB"

      parsed_json = JSON.parse( response.body )

      expect( response.status ).to eq(200)
      expect( parsed_json ).to eq( {
          "id" => Topic.last.id,
          "message" => "OK"
      })
    end

    it "should save failed" do
      post "/api/v1/topics"

      parsed_json = JSON.parse( response.body )

      expect( response.status ).to eq(400)
    end
  end

end
