# frozen_string_literal: true

class SegmentedToggleComponent < ViewComponent::Base
  # items: array of hashes { label:, url:, target:, value: }
  def initialize(frame:, items:, current: nil, controller: "segmented-toggle", turbo_action: "advance")
    @items = items
    @current = current || items.first[:value]
    @controller = controller
    @frame = frame
    @turbo_action = turbo_action
  end

  def active?(value)
    @current.to_s == value.to_s
  end
end
