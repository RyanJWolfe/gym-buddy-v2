require 'rails_helper'

RSpec.describe "workout_types/edit", type: :view do
  let(:workout_type) {
    WorkoutType.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:workout_type, workout_type)
  end

  it "renders the edit workout_type form" do
    render

    assert_select "form[action=?][method=?]", workout_type_path(workout_type), "post" do

      assert_select "input[name=?]", "workout_type[name]"
    end
  end
end
