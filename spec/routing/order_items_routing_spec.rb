require "rails_helper"

RSpec.describe OrderItemsController, type: :routing do
  describe "routing" do

    xit "routes to #index" do
      expect(:get => "/orders/1/order_items").to route_to("order_items#index")
    end

    xit "routes to #new" do
      expect(:get => "/order_items/new").to route_to("order_items#new")
    end

    xit "routes to #show" do
      expect(:get => "/order_items/1").to route_to("order_items#show", :id => "1")
    end

    xit "routes to #edit" do
      expect(:get => "/order_items/1/edit").to route_to("order_items#edit", :id => "1")
    end

    xit "routes to #create" do
      expect(:post => "/order_items").to route_to("order_items#create")
    end

    xit "routes to #update via PUT" do
      expect(:put => "/order_items/1").to route_to("order_items#update", :id => "1")
    end

    xit "routes to #update via PATCH" do
      expect(:patch => "/order_items/1").to route_to("order_items#update", :id => "1")
    end

    xit "routes to #destroy" do
      expect(:delete => "/order_items/1").to route_to("order_items#destroy", :id => "1")
    end

  end
end
