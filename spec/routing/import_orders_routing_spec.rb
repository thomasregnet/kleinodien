require "rails_helper"

RSpec.describe ImportOrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/import_orders").to route_to("import_orders#index")
    end

    it "routes to #new" do
      expect(get: "/import_orders/new").to route_to("import_orders#new")
    end

    it "routes to #show" do
      expect(get: "/import_orders/1").to route_to("import_orders#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/import_orders/1/edit").to route_to("import_orders#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/import_orders").to route_to("import_orders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/import_orders/1").to route_to("import_orders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/import_orders/1").to route_to("import_orders#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/import_orders/1").to route_to("import_orders#destroy", id: "1")
    end
  end
end
