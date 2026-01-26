module AvatarsHelper
  AVATAR_SIZE_CLASSES = {
    xs: "w-6 h-6",
    sm: "w-8 h-8",
    md: "w-10 h-10",
    mdlg: "w-12 h-12 md:w-16 md:h-16",
    l: "w-12 h-12",
    lg: "w-16 h-16",
    xl: "w-20 h-20",
    xxl: "w-32 h-32"
  }.freeze

  AVATAR_INITIALS_SIZE_CLASSES = {
    xs: "text-[9px]",
    sm: "text-xs",
    md: "text-sm",
    mdlg: "md:text-xl",
    l: "text-base",
    lg: "text-xl",
    xl: "text-2xl",
    xxl: "text-4xl"
  }.freeze

  def render_avatar(user, size: :sm, html_options: {})
    # avatar_url = user.avatar_url(self) # TODO: add avatars later
    avatar_url = nil
    alt = user.initials
    if avatar_url.blank?
      initials = user.initials
      avatar_initials_tag(initials, size:, alt:, html_options:)
    else
      avatar_tag(avatar_url, size:, alt:, html_options:)
    end
  end

  def avatar_tag(avatar_url, size: :sm, alt: "Avatar", html_options: {})
    size_class = AVATAR_SIZE_CLASSES[size] || AVATAR_SIZE_CLASSES[:sm]
    classes = [ size_class, "shrink-0 rounded-full object-cover border-2 border-gray-200 dark:border-gray-300 relative", html_options[:class] ].compact.join(" ")
    options = html_options.except(:class).merge({
                                                  class: classes,
                                                  alt: alt
                                                })
    image_tag(avatar_url, **options)
  end

  def avatar_initials_tag(initials, size: :sm, alt: "Avatar", html_options: {})
    size_class = AVATAR_SIZE_CLASSES[size] || AVATAR_SIZE_CLASSES[:sm]
    initials_size_class = AVATAR_INITIALS_SIZE_CLASSES[size] || AVATAR_INITIALS_SIZE_CLASSES[:sm]
    classes = [ initials_size_class, size_class, "shrink-0 border-2 border-gray-200 dark:border-gray-300 relative inline-flex items-center justify-center overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600", html_options[:class] ].compact.join(" ")
    options = html_options.except(:class).merge({
                                                  class: classes,
                                                  alt: alt
                                                })
    content_tag(:div, **options) do
      content_tag(:span, initials, class: "font-medium text-gray-600 dark:text-gray-300")
    end
  end

  def default_avatar_url
    asset_path("avatars/default.jpg")
  end
end
