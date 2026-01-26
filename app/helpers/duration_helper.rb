module DurationHelper
  def duration_options(max_minutes: 12 * 60)
    (1..max_minutes).map do |minutes|
      seconds = minutes * 60
      [format_duration(minutes), seconds]
    end
  end

  def format_duration(minutes)
    hours = minutes / 60
    mins  = minutes % 60

    if hours.positive?
      "#{hours} h #{mins} min"
    else
      "#{mins} min"
    end
  end

  def format_duration_seconds(total_seconds)
    total_minutes = (total_seconds / 60).to_i
    format_duration(total_minutes)
  end
end
