# frozen_string_literal: true

class DurationCalculator
  # Returns duration in seconds (integer), or nil if inputs missing.
  # Negative results are clamped to 0.
  def self.seconds(start_time, end_time)
    return nil if start_time.nil? || end_time.nil?

    (end_time.to_i - start_time.to_i).clamp(0, Float::INFINITY).to_i
  end
end
