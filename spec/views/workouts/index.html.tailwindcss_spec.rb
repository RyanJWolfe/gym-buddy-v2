require 'rails_helper'

RSpec.describe "workouts/index", type: :view do
  before(:each) do
    assign(:workouts, [
      Workout.create!(
        user: nil,
        workout_type: nil,
        duration: 2
      ),
      Workout.create!(
        user: nil,
        workout_type: nil,
        duration: 2
      )
    ])
  end

  it "renders a list of workouts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
