class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include RequestAuth

  def commonResponse(status, data, code)
    responseHash = {:status => status, :data => data, :code => code}
    render json: responseHash.to_json
  end


  def commonSuccessResponse(data)
    commonResponse('success', data, 200)
  end

  def commonErrorResponse(data, error_code=400)
    commonResponse('error', data, error_code)
  end

  def commonArrayResponse(list, count)
    commonSuccessResponse({:list=>list, :count=>count})
  end

  def commonUserResponse(user)
    user = {:user_id => user.id, :user_email => user.email}
  end

  def commonCategoryResponse(category)
    category = {:id => category.id, :name => category.name, :catalog_name => category.name}
  end

  def commonProductResponse(product)
    product = {:id => product.id, 
            :catalog_name => product.name,
            :category_name => product.name,
            :name => product.name,
            :sku => product.sku,
            :price => product.price,
            :short_description => product.short_description,
            :image => product.image
           }
  end
 
 # CUSTOM EXCEPTION HANDLING
  rescue_from Exception do |e|
    error(e)
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  protected

  def error(e)
    #render :template => "#{Rails::root}/public/404.html" 
    if env["ORIGINAL_FULLPATH"] =~ /^\/api/
    error_info = {
      :error => "internal-server-error",
      :exception => "#{e.class.name} : #{e.message}",
    }
    #error_info[:trace] = e.backtrace[0,10] if Rails.env.development?
    render :json => error_info.to_json, :status => 500
    else
      #render :text => "500 Internal Server Error", :status => 500 # You can render your own template here
      raise e
    end
  end
end
