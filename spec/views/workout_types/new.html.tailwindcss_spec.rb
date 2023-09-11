require 'rails_helper'

RSpec.describe "workout_types/new", type: :view do
  before(:each) do
    assign(:workout_type, WorkoutType.new(
      name: "MyString"
    ))
  end

  it "renders new workout_type form" do
    render

    assert_select "form[action=?][method=?]", workout_types_path, "post" do

      assert_select "input[name=?]", "workout_type[name]"
    end
  end
end
