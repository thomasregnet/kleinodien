require "rails_helper"

RSpec.describe ReleaseCopiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/release_copies").to route_to("release_copies#index")
    end

    it "routes to #new" do
      expect(get: "/release_copies/new").to route_to("release_copies#new")
    end

    it "routes to #show" do
      expect(get: "/release_copies/1").to route_to("release_copies#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/release_copies/1/edit").to route_to("release_copies#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/release_copies").to route_to("release_copies#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/release_copies/1").to route_to("release_copies#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/release_copies/1").to route_to("release_copies#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/release_copies/1").to route_to("release_copies#destroy", id: "1")
    end
  end
end
