# frozen_string_literal: true

class SegmentedToggleComponent < ViewComponent::Base
  # items: array of hashes { label:, url:, target:, value: }
  def initialize(items:, current: nil, controller: 'workouts-toggle', frame: 'workouts_view', turbo_action: 'advance')
    @items = items
    @current = current
    @controller = controller
    @frame = frame
    @turbo_action = turbo_action
  end

  def active?(value)
    if @current.blank?
      value.to_s == 'list'
    else
      @current.to_s == value.to_s
    end
  end
end
