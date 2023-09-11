require 'rails_helper'

RSpec.describe "exercise_sets/index", type: :view do
  before(:each) do
    assign(:exercise_sets, [
      ExerciseSet.create!(
        reps: 2,
        weight: 3.5,
        distance: 4.5,
        duration: 5,
        exercise: nil
      ),
      ExerciseSet.create!(
        reps: 2,
        weight: 3.5,
        distance: 4.5,
        duration: 5,
        exercise: nil
      )
    ])
  end

  it "renders a list of exercise_sets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
