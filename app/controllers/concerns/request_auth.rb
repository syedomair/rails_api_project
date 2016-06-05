module RequestAuth
  extend ActiveSupport::Concern

  attr  :accessType, :userEmail, :userPasword
  included do
    before_filter :restrict_access
  end

  private
    def restrict_access
      header_token = request.headers["HTTP_SO_AUTH"]
      preg_rex='custom_auth api_key="([^"]+)", access_type="([^"]+)", user_email="([^"]+)", password="([^"]+)"'
      begin
        match_array = header_token.match(/#{preg_rex}/)
        _apiKey = match_array[1]
        @accessType = match_array[2]
        @userEmail = match_array[3]
        @userPassword = match_array[4]
      rescue
        commonErrorResponse( {:message => 'Invalid header', :app_error_code => 1001} )
        return
      end

      commonErrorResponse( {:message => 'Invalid API Key', :app_error_code => 1002})if _apiKey != "12345"

    end

    def restrict_access_secured
      if @accessType == 'secured'
        if ! User.authenticate(@userEmail, @userPassword)
          commonErrorResponse( {:message => 'Invalid email/password', :app_error_code => 1004} )
          return
        end
      end
    end

  module RequestAuthSecured 
    extend ActiveSupport::Concern

    include RequestAuth

    included do
      before_filter :restrict_access_secured
    end
  end

end


