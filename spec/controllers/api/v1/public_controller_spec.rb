require 'spec_helper'
require "base64"

describe Api::V1::PublicController do

  user_email = FFaker::Internet.email
  user_password =  Base64.encode64('12345')
  api_key = "secret_key"
  api_key_invalid = "123456"
  #access_type = "secured"
  access_type = "public"

  describe "signup" do
    it "check API request header"do
      
      @user_attributes = { "email":user_email , "password":user_password , "password_confirmation":user_password }
      token = "custom_auth invalidapi_key=\"#{api_key}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{user_password}\"" 
      request.headers["HTTP_SO_AUTH"] = token
      post :signup, {user:@user_attributes} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:app_error_code]).to eql 1001
    end

    it "check API key"do
      user_attributes = { "email":user_email , "password":user_password , "password_confirmation":user_password }
      token = "custom_auth api_key=\"#{api_key_invalid}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{user_password}\"" 

      request.headers["HTTP_SO_AUTH"] = token
      post :signup, {user:user_attributes} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:app_error_code]).to eql 1002
    end

    it "check password and password_confirmation are same"do
      invalid_password = "123456" 
      
      user_attributes = { "email":user_email , "password":user_password , "password_confirmation":invalid_password }
      token = "custom_auth api_key=\"#{api_key}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{user_password}\"" 

      request.headers["HTTP_SO_AUTH"] = token
      post :signup, {user:user_attributes} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:app_error_code]).to eql 1003
      expect(json_response[:data][:message]).to eql %Q(Password confirmation doesn't match Password)
    end

    it "check email validity (no email) "do
      #user_attributes = { "email":user_email+".com" , "password":user_password , "password_confirmation":user_password }
      user_attributes = {  "password":user_password , "password_confirmation":user_password }
      token = "custom_auth api_key=\"#{api_key}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{user_password}\"" 

      request.headers["HTTP_SO_AUTH"] = token
      post :signup, {user:user_attributes} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:app_error_code]).to eql 1003
      expect(json_response[:data][:message]).to eql %Q(Email can't be blank)
    end

    it "check email validity (invalid email) "do
      user_attributes = { "email":user_email+" .com" , "password":user_password , "password_confirmation":user_password }
      token = "custom_auth api_key=\"#{api_key}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{user_password}\"" 

      request.headers["HTTP_SO_AUTH"] = token
      post :signup, {user:user_attributes} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      #puts json_response
      expect(json_response[:data][:app_error_code]).to eql 1003
      expect(json_response[:data][:message]).to eql %Q(Email is not a valid email)
    end

    it "success "do
      user_attributes = { "email":user_email , "password":user_password , "password_confirmation":user_password }
      token = "custom_auth api_key=\"#{api_key}\", access_type=\"#{access_type}\", user_email=\"#{user_email}\", password=\"#{user_password}\"" 

      request.headers["HTTP_SO_AUTH"] = token
      post :signup, {user:user_attributes} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:user_email]).to eql user_email
    end
  end
  
end
