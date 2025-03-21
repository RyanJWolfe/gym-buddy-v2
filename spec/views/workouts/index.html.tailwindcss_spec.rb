require 'rails_helper'

RSpec.describe "workouts/index", type: :view do
  before(:each) do
    assign(:workouts, [
      Workout.create!(
        user: nil,
        notes: "MyText"
      ),
      Workout.create!(
        user: nil,
        notes: "MyText"
      )
    ])
  end

  it "renders a list of workouts" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
