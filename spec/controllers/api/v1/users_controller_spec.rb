require 'spec_helper'
require "base64"

describe Api::V1::UsersController do

  user_email = 'syedkhalidomair@gmail.com'
  user_password =  Base64.encode64('12345')
  api_key = "secret_key"
  access_type = "secured"

  describe "signin" do
    it "invalid password "do
      invalidPassword = "123"
      token = "custom_auth api_key=\"#{api_key}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{invalidPassword}\"" 

      request.headers["HTTP_SO_AUTH"] = token
      post :signin, {} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      #puts json_response
      expect(json_response[:data][:app_error_code]).to eql 1004
      expect(json_response[:data][:message]).to eql %Q(Invalid email/password)
    end

#    it "valid password "do
#      access_type = "secured"
#      user_attributes = { "email":user_email , "password":user_password }
#      token = "custom_auth api_key=\"#{api_key}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{user_password}\"" 
#
#      request.headers["HTTP_SO_AUTH"] = token
#      post :signin, {user:user_attributes} , format: :json 
#      json_response = JSON.parse(response.body, symbolize_names: true)
#      puts json_response
#      expect(json_response[:data][:user_email]).to eql user_email
#    end
  end


end
