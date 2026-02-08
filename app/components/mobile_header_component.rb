# frozen_string_literal: true

class MobileHeaderComponent < ViewComponent::Base
  renders_one :action

  def initialize(title:, back_href: nil, back_label: "Back", aria_label: "Header")
    @title = title
    @back_href = back_href
    @back_label = back_label
    @aria_label = aria_label
  end
end
