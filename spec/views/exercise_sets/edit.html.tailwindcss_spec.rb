require 'rails_helper'

RSpec.describe "exercise_sets/edit", type: :view do
  let(:exercise_set) {
    ExerciseSet.create!(
      reps: 1,
      weight: 1.5,
      distance: 1.5,
      duration: 1,
      exercise: nil
    )
  }

  before(:each) do
    assign(:exercise_set, exercise_set)
  end

  it "renders the edit exercise_set form" do
    render

    assert_select "form[action=?][method=?]", exercise_set_path(exercise_set), "post" do

      assert_select "input[name=?]", "exercise_set[reps]"

      assert_select "input[name=?]", "exercise_set[weight]"

      assert_select "input[name=?]", "exercise_set[distance]"

      assert_select "input[name=?]", "exercise_set[duration]"

      assert_select "input[name=?]", "exercise_set[exercise_id]"
    end
  end
end
