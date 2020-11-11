require "rails_helper"

RSpec.describe ReleaseImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/release_images").to route_to("release_images#index")
    end

    it "routes to #new" do
      expect(get: "/release_images/new").to route_to("release_images#new")
    end

    it "routes to #show" do
      expect(get: "/release_images/1").to route_to("release_images#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/release_images/1/edit").to route_to("release_images#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/release_images").to route_to("release_images#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/release_images/1").to route_to("release_images#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/release_images/1").to route_to("release_images#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/release_images/1").to route_to("release_images#destroy", id: "1")
    end
  end
end
