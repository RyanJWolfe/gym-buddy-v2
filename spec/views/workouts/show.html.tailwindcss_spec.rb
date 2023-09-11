require 'rails_helper'

RSpec.describe "workouts/show", type: :view do
  before(:each) do
    assign(:workout, Workout.create!(
      user: nil,
      workout_type: nil,
      duration: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
