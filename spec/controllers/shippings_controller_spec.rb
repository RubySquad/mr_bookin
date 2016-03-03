require 'rails_helper'

RSpec.describe ShippingsController, type: :controller do

  describe "GET #get_shipping_price" do
    it "returns http success" do
      get :get_shipping_price
      expect(response).to have_http_status(:success)
    end
  end

end
