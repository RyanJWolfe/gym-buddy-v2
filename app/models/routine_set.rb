class RoutineSet < ApplicationRecord
  belongs_to :routine_exercise # TODO: might need to counter cache

  after_initialize :set_default_set_number, if: :new_record?

  private

  def set_default_set_number
    self.set_number ||= 1
  end
end
