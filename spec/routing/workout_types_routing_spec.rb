require "rails_helper"

RSpec.describe WorkoutTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/workout_types").to route_to("workout_types#index")
    end

    it "routes to #new" do
      expect(get: "/workout_types/new").to route_to("workout_types#new")
    end

    it "routes to #show" do
      expect(get: "/workout_types/1").to route_to("workout_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/workout_types/1/edit").to route_to("workout_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/workout_types").to route_to("workout_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/workout_types/1").to route_to("workout_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/workout_types/1").to route_to("workout_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/workout_types/1").to route_to("workout_types#destroy", id: "1")
    end
  end
end
