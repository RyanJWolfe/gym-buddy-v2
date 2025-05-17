# frozen_string_literal: true

class DateBannerComponent < ViewComponent::Base
  def initialize(date:)
    @date = date
  end
end
