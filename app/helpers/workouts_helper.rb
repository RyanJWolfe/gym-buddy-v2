module WorkoutsHelper
  # Helper method for relative time display
  def relative_time_ago(date)
    seconds_ago = (Time.current - date.to_time).to_i
    if seconds_ago < 60
      "just now"
    elsif seconds_ago < 3600
      "#{(seconds_ago / 60).to_i} #{(seconds_ago / 60).to_i == 1 ? 'minute' : 'minutes'} ago"
    elsif seconds_ago < 86400
      "#{(seconds_ago / 3600).to_i} #{(seconds_ago / 3600).to_i == 1 ? 'hour' : 'hours'} ago"
    elsif seconds_ago < 604800
      "#{(seconds_ago / 86400).to_i} #{(seconds_ago / 86400).to_i == 1 ? 'day' : 'days'} ago"
    elsif seconds_ago < 1209600 # 2 weeks
      "#{(seconds_ago / 604800).to_i} #{(seconds_ago / 604800).to_i == 1 ? 'week' : 'weeks'} ago"
    else
      date.strftime("%b %d, %Y")
    end
  end
end
