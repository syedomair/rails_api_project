require 'spec_helper'
require "base64"

describe Api::V1::UsersController do

  describe "Testing create method" do
    it " it checks  post create method "do

      @user_email = FFaker::Internet.email
      @user_password = "12345"
      @api_key = "12345"
      
      #@user_password = @user_password.encrypt(:symmetric, :password => 'secret_key')
      @user_password = Base64.encode64(@user_password);
      
      @user_attributes = { "email":@user_email , "password":@user_password , "confirm_password":@user_password }
      #"Name is #{name}, ID is #{id}"
      token = "custom_auth api_key=\"#{@api_key}\", user_email=\"#{@user_email}\", password=\"#{@user_password}\"" 
      puts token
      request.headers["HTTP_SO_AUTH"] = token
      post :create, {user:@user_attributes} , format: :json 
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:email]).to eql @user_email
      
      #it { should respond_with 200 } 
      puts "Test response.body=> #{response.body}"  
    end
  end
end
