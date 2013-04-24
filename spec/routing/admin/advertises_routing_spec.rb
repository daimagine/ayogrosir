require "spec_helper"

describe Admin::AdvertisesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/advertises").should route_to("admin/advertises#index")
    end

    it "routes to #new" do
      get("/admin/advertises/new").should route_to("admin/advertises#new")
    end

    it "routes to #show" do
      get("/admin/advertises/1").should route_to("admin/advertises#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/advertises/1/edit").should route_to("admin/advertises#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/advertises").should route_to("admin/advertises#create")
    end

    it "routes to #update" do
      put("/admin/advertises/1").should route_to("admin/advertises#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/advertises/1").should route_to("admin/advertises#destroy", :id => "1")
    end

  end
end
