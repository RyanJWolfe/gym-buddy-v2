# frozen_string_literal: true

class MobileHeaderComponent < ViewComponent::Base
  renders_one :action

  def initialize(title:, back_href: nil, back_label: nil, close_modal: false, aria_label: "Header")
    @title = title
    @back_href = back_href
    @back_label = back_label
    @close_modal = close_modal
    @aria_label = aria_label
  end
end
