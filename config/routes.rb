Rails.application.routes.draw do

  RailsApiProject::Application.routes.draw do
  # We are going to list our resources here
    namespace :api do
      scope module: :v1 do
        resources :catalogs, :only => [:show, :create] 
        resources :users, :only => [:signin] do
          collection do
            post 'signin'
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

