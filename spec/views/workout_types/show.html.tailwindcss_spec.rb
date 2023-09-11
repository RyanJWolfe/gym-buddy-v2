require 'rails_helper'

RSpec.describe "workout_types/show", type: :view do
  before(:each) do
    assign(:workout_type, WorkoutType.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
