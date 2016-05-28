Rails.application.routes.draw do

  RailsApiProject::Application.routes.draw do
  # We are going to list our resources here
    namespace :api do
      scope module: :v1 do
        resources :catalogs, :only => [:show, :create] 
        resources :users, :only => [:create] 
        resources :public, :only=>[:signup, :signin] do 
          collection do
            post 'signup'
            post 'signin'
          end
        end
      end
    end
  end
end
