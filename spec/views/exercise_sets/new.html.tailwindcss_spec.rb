require 'rails_helper'

RSpec.describe "exercise_sets/new", type: :view do
  before(:each) do
    assign(:exercise_set, ExerciseSet.new(
      reps: 1,
      weight: 1.5,
      distance: 1.5,
      duration: 1,
      exercise: nil
    ))
  end

  it "renders new exercise_set form" do
    render

    assert_select "form[action=?][method=?]", exercise_sets_path, "post" do

      assert_select "input[name=?]", "exercise_set[reps]"

      assert_select "input[name=?]", "exercise_set[weight]"

      assert_select "input[name=?]", "exercise_set[distance]"

      assert_select "input[name=?]", "exercise_set[duration]"

      assert_select "input[name=?]", "exercise_set[exercise_id]"
    end
  end
end
