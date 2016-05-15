Rails.application.routes.draw do

  RailsApiProject::Application.routes.draw do
  # We are going to list our resources here
    namespace :api do
      scope module: :v1 do
        resources :catalogs, :only => [:show, :create] 
      end
    end
  end
end
