require 'rails_helper'

RSpec.describe "workouts/new", type: :view do
  before(:each) do
    assign(:workout, Workout.new(
      user: nil,
      workout_type: nil,
      duration: 1
    ))
  end

  it "renders new workout form" do
    render

    assert_select "form[action=?][method=?]", workouts_path, "post" do

      assert_select "input[name=?]", "workout[user_id]"

      assert_select "input[name=?]", "workout[workout_type_id]"

      assert_select "input[name=?]", "workout[duration]"
    end
  end
end
