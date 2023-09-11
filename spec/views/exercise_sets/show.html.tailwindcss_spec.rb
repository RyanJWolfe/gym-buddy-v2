require 'rails_helper'

RSpec.describe "exercise_sets/show", type: :view do
  before(:each) do
    assign(:exercise_set, ExerciseSet.create!(
      reps: 2,
      weight: 3.5,
      distance: 4.5,
      duration: 5,
      exercise: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(//)
  end
end
