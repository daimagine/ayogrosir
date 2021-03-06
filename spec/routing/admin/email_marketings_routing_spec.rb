require "spec_helper"

describe Admin::EmailMarketingsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/email_marketings").should route_to("admin/email_marketings#index")
    end

    it "routes to #new" do
      get("/admin/email_marketings/new").should route_to("admin/email_marketings#new")
    end

    it "routes to #show" do
      get("/admin/email_marketings/1").should route_to("admin/email_marketings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/email_marketings/1/edit").should route_to("admin/email_marketings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/email_marketings").should route_to("admin/email_marketings#create")
    end

    it "routes to #update" do
      put("/admin/email_marketings/1").should route_to("admin/email_marketings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/email_marketings/1").should route_to("admin/email_marketings#destroy", :id => "1")
    end

  end
end
