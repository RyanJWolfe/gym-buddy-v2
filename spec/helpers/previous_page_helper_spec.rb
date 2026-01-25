require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PreviousPageHelper. For example:
#
# describe PreviousPageHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PreviousPageHelper, type: :helper do
  describe "#path_to_previous_page" do
    context "when there are multiple previous pages in session" do
      it "returns the most recent previous page" do
        session[:previous_pages] = ["/workouts", "/dashboard", "/workouts/1"]
        expect(helper.path_to_previous_page).to eq("/workouts")
      end
    end

    context "when there is only one previous page in session" do
      it "returns the root path" do
        session[:previous_pages] = ["/workouts"]
        expect(helper.path_to_previous_page).to eq(root_path)
      end
    end

    context "when there are no previous pages in session" do
      it "returns the root path" do
        session[:previous_pages] = nil
        expect(helper.path_to_previous_page).to eq(root_path)
      end
    end
  end
end
