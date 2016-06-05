class Api::V1::PublicController < SecuredApplicationController
#class Api::V1::PublicController < ApplicationController
  protect_from_forgery with: :null_session

  def signup
    @user = User.new(user_params)
    if @user.save
      commonSucessResponse(commonUserResponse(@user))
    else
      commonErrorResponse( {:message => @user.errors.full_messages[0], :app_error_code => 1003}, 400 ) 
    end
  end

  def signin
      user = User.find_by_email(params[:user][:email])
      commonSucessResponse(commonUserResponse(user))
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def commonUserResponse(user)
      user = {:user_id => user.id, :user_email => user.email}
    end
end

