require 'spec_helper'

describe Api::V1::CatalogsController do

  describe "Testing show method" do
    it " it checks catalog id "do
      get :show, id: 1, format: :json
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:id]).to eql 1
    end
  end
end
