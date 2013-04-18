require "spec_helper"

describe Admin::MarketsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/markets").should route_to("admin/markets#index")
    end

    it "routes to #new" do
      get("/admin/markets/new").should route_to("admin/markets#new")
    end

    it "routes to #show" do
      get("/admin/markets/1").should route_to("admin/markets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/markets/1/edit").should route_to("admin/markets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/markets").should route_to("admin/markets#create")
    end

    it "routes to #update" do
      put("/admin/markets/1").should route_to("admin/markets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/markets/1").should route_to("admin/markets#destroy", :id => "1")
    end

  end
end
