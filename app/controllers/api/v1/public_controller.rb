class Api::V1::PublicController < ApplicationController
  protect_from_forgery with: :null_session

  def signup
    @user = User.new(user_params)
    if @user.save
      commonSuccessResponse(commonUserResponse(@user))
    else
      commonErrorResponse( {:message => @user.errors.full_messages[0], :app_error_code => 1003}, 400 ) 
    end
  end

  def categories
     rtnList=[]
     categories = Category.where(catalogs_id: params[:id]).all
     categories.each do |category|
       rtnList = rtnList.push(commonCategoryResponse(category))
     end
     commonArrayResponse(rtnList, rtnList.count)
  end

  def products
     rtnList=[]
     products = Product.where(categories_id: params[:id]).all
     products.each do |product|
       rtnList = rtnList.push(commonProductResponse(product))
     end
     commonArrayResponse(rtnList, rtnList.count)
  end

  def product
    product = Product.find_by id: params[:id]
    commonSuccessResponse(commonProductResponse(product))
  end

  def product_featured
    rtnList=[]
    products = Product.where(featured: true).all
    products.each do |product|
      rtnList = rtnList.push(commonProductResponse(product))
    end
    commonArrayResponse(rtnList, rtnList.count)
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
  
end

