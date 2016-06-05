class SecuredApplicationController < ApplicationController

  include RequestAuth::RequestAuthSecured

end
