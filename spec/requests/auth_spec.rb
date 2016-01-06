require 'rails_helper'

RSpec.describe "Auth", type: :request do

  let!(:user) {  User.create!( :email => "foo@example.org", :password => "12345678", :fb_uid => "1234" ) }

  describe "facebook" do
    it "should login by facebook access_token (not existing)" do
      fb_data = {
        "id" => "5678",
        "email" => "bar@example.org",
        "name" => "ihower"
      }

      expect(User).to receive(:get_fb_data).with("fb-token-xxxx").and_return(fb_data)

      post "/api/v1/login", :access_token => "fb-token-xxxx"

      expect(response).to have_http_status(200)

      user = User.last

      data = {
        "message" => "Ok",
        "auth_token" => user.authentication_token,
        "user_id" => user.id
      }

      expect(JSON.parse(response.body)).to eq(data)
    end


    it "should login by facebook access_token (existing)" do
      fb_data = {
        "id" => "1234",
        "email" => "foo@example.org",
        "name" => "ihower"
      }

      expect(User).to receive(:get_fb_data).with("fb-token-xxxx").and_return(fb_data)

      post "/api/v1/login", :access_token => "fb-token-xxxx"

      expect(response).to have_http_status(200)

      data = {
        "message" => "Ok",
        "auth_token" => user.authentication_token,
        "user_id" => user.id
      }

      expect(JSON.parse(response.body)).to eq(data)
    end

    it "should login failed" do
      expect(User).to receive(:get_fb_data).with("qq").and_return(nil)

      post "/api/v1/login", :access_token => "qq"

      expect(response).to have_http_status(401)
    end

  end


  describe "login" do
    it "should login successfully" do
       post "/api/v1/login", :email => user.email, :password => "12345678"

       expect(response).to have_http_status(200)

       data = {
         "message" => "Ok",
         "auth_token" => user.authentication_token,
         "user_id" => user.id
       }

       expect(JSON.parse(response.body)).to eq(data)
     end

    it "should login failed if wrong email or password" do
      post "/api/v1/login"

      expect(response).to have_http_status(401)
    end


    it "should login failed if wrong password" do
      post "/api/v1/login", :email => user.email, :password => "xxx"

      expect(response).to have_http_status(401)
    end
  end

  describe "logout" do
    it "should auth error if no auth_token" do
      post "/api/v1/logout"

      expect(response).to have_http_status(401)
    end

    it "should expire user auth token" do
      old_auth_token = user.authentication_token

      post "/api/v1/logout", :auth_token => old_auth_token

      expect(response).to have_http_status(200)

      user.reload
      expect( user.authentication_token ).not_to eq(old_auth_token)
    end

  end

end
