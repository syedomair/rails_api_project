class Api::V1::UsersController < SecuredApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  def signin
      user = User.find_by_email(params[:user][:email])
      commonSuccessResponse(commonUserResponse(user))
  end

  def show
      user = User.find_by id: params[:id]
      commonSuccessResponse(commonUserResponse(user))
  end

  def update
      user = User.find_by id: params[:id]
      user.first_name = (params[:user][:first_name])
      user.last_name = (params[:user][:last_name])

      if user.save(validate: false)
        commonSuccessResponse(commonUserResponse(user))
      else
        commonErrorResponse( {:message => user.errors.full_messages[0], :app_error_code => 1006}, 400 ) 
      end
  end
end

