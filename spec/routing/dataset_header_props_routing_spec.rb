require "spec_helper"

describe DatasetHeaderPropsController do
  describe "routing" do
    it "routes to #index" do
      get("datasets/99/dataset_header_props").should route_to("dataset_header_props#index", :dataset_id => "99")
    end

    it "routes to #new" do
      get("datasets/99/dataset_header_props/new").should route_to("dataset_header_props#new", :dataset_id => "99")
    end

    it "routes to #show" do
      get("datasets/99/dataset_header_props/1").should route_to("dataset_header_props#show", :id => "1", :dataset_id => "99")
    end

    it "routes to #edit" do
      get("datasets/99/dataset_header_props/1/edit").should route_to("dataset_header_props#edit", :id => "1", :dataset_id => "99")
    end

    it "routes to #create" do
      post("datasets/99/dataset_header_props").should route_to("dataset_header_props#create", :dataset_id => "99")
    end

    it "routes to #update" do
      put("datasets/99/dataset_header_props/1").should route_to("dataset_header_props#update", :id => "1", :dataset_id => "99")
    end

    it "routes to #destroy" do
      delete("datasets/99/dataset_header_props/1").should route_to("dataset_header_props#destroy", :id => "1", :dataset_id => "99")
    end

  end
end
