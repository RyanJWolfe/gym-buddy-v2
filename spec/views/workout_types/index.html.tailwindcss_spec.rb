require 'rails_helper'

RSpec.describe "workout_types/index", type: :view do
  before(:each) do
    assign(:workout_types, [
      WorkoutType.create!(
        name: "Name"
      ),
      WorkoutType.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of workout_types" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
