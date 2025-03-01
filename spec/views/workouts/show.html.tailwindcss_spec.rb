require 'rails_helper'

RSpec.describe "workouts/show", type: :view do
  before(:each) do
    assign(:workout, Workout.create!(
      user: nil,
      notes: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
