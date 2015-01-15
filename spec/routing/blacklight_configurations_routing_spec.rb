require "spec_helper"

describe BlacklightConfigurationsController do
  describe "routing" do

    it "routes to #index" do
      get("/blacklight_configurations").should route_to("blacklight_configurations#index")
    end

    it "routes to #new" do
      get("/blacklight_configurations/new").should route_to("blacklight_configurations#new")
    end

    it "routes to #show" do
      get("/blacklight_configurations/1").should route_to("blacklight_configurations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/blacklight_configurations/1/edit").should route_to("blacklight_configurations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/blacklight_configurations").should route_to("blacklight_configurations#create")
    end

    it "routes to #update" do
      put("/blacklight_configurations/1").should route_to("blacklight_configurations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/blacklight_configurations/1").should route_to("blacklight_configurations#destroy", :id => "1")
    end

    # New routes for Title edit/update
    it "routes to #edit_title" do
       get("/blacklight_configurations/1/edit_title").should route_to("blacklight_configurations#edit_title", :id => "1")
    end

    it "routes to #update_title" do
      patch("/blacklight_configurations/1/update_title").should route_to("blacklight_configurations#update_title", :id => "1")
    end

  end
end