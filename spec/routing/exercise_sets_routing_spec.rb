require "rails_helper"

RSpec.describe ExerciseSetsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/exercise_sets").to route_to("exercise_sets#index")
    end

    it "routes to #new" do
      expect(get: "/exercise_sets/new").to route_to("exercise_sets#new")
    end

    it "routes to #show" do
      expect(get: "/exercise_sets/1").to route_to("exercise_sets#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/exercise_sets/1/edit").to route_to("exercise_sets#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/exercise_sets").to route_to("exercise_sets#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/exercise_sets/1").to route_to("exercise_sets#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/exercise_sets/1").to route_to("exercise_sets#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/exercise_sets/1").to route_to("exercise_sets#destroy", id: "1")
    end
  end
end
