module FormHelper
  def form_field_error(resource, field, friendly_blank_message: nil)
    return unless resource.errors[field].any?

    error = resource.errors[field].first
    message =
      if error == "can't be blank"
        friendly_blank_message || "#{field.to_s.titleize} is required"
      else
        field.to_s.titleize + ' ' + error.to_s
      end

    content_tag(:div, class: "flex items-center gap-1 text-xs mt-1 text-red-500") do
      concat(content_tag(:span, "⚠️", class: "text-base"))
      concat(message)
    end
  end
end
