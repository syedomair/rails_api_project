class Api::V1::CatalogsController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json
  def show
    @catalog =  Catalog.find(params[:id])
    render json: @catalog.to_json
  end

  def create
    @catalog = Catalog.new(catalog_params)
    @catalog.save
    render json: @catalog.to_json
  end

  private
    def catalog_params
      params.require(:catalog).permit(:name)
    end
end

