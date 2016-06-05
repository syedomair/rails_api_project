class Api::V1::UsersController < SecuredApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  def signin
      user = User.find_by_email(params[:user][:email])
      commonSuccessResponse(commonUserResponse(user))
  end
end

