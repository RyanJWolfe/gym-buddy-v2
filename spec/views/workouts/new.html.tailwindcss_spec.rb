require 'rails_helper'

RSpec.describe "workouts/new", type: :view do
  before(:each) do
    assign(:workout, Workout.new(
      user: nil,
      notes: "MyText"
    ))
  end

  it "renders new workout form" do
    render

    assert_select "form[action=?][method=?]", workouts_path, "post" do

      assert_select "input[name=?]", "workout[user_id]"

      assert_select "textarea[name=?]", "workout[notes]"
    end
  end
end
