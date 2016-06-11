Rails.application.routes.draw do

  RailsApiProject::Application.routes.draw do
  # We are going to list our resources here
    namespace :api do
      scope module: :v1 do
        resources :catalogs, :only => [:show] 
        resources :users, :only => [:signin, :get_user] do
          collection do
            post 'signin'
            get 'users/:id', :to => 'users#show'
            patch 'users/:id', :to => 'users#update'
          end
        end
        resources :public, :only=>[:signup, 'list_categories', 'list_products', 'get_product' ] do 
          collection do
            post 'signup'
            get 'categories/catalog:id', :to => 'public#categories'
            get 'products/category:id', :to => 'public#products'
            get 'products/:id', :to => 'public#product'
            get 'products-featured', :to => 'public#product_featured'
          end
        end
      end
    end
  end
end

