require "rails_helper"

RSpec.describe EventeditsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/eventedits").to route_to("eventedits#index")
    end

    it "routes to #new" do
      expect(get: "/eventedits/new").to route_to("eventedits#new")
    end

    it "routes to #show" do
      expect(get: "/eventedits/1").to route_to("eventedits#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/eventedits/1/edit").to route_to("eventedits#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/eventedits").to route_to("eventedits#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/eventedits/1").to route_to("eventedits#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/eventedits/1").to route_to("eventedits#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/eventedits/1").to route_to("eventedits#destroy", id: "1")
    end
  end
end
