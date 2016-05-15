Rails.application.routes.draw do

  RailsApiProject::Application.routes.draw do
  # Api definition
  #  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
  #    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
  # We are going to list our resources here
    namespace :api do
      scope module: :v1 do
        resources :users, :only => [:show, :create] 
        resources :sessions, :only => [:create, :destroy]
        #do 
        #end
        resources :catalogs, :only => [:show, :create] 
      end
    end
  end
end
