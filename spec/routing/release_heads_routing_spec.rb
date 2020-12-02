require "rails_helper"

RSpec.describe ReleaseHeadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/release_heads").to route_to("release_heads#index")
    end

    it "routes to #new" do
      expect(get: "/release_heads/new").to route_to("release_heads#new")
    end

    it "routes to #show" do
      expect(get: "/release_heads/1").to route_to("release_heads#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/release_heads/1/edit").to route_to("release_heads#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/release_heads").to route_to("release_heads#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/release_heads/1").to route_to("release_heads#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/release_heads/1").to route_to("release_heads#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/release_heads/1").to route_to("release_heads#destroy", id: "1")
    end
  end
end
