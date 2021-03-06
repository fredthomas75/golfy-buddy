module ApplicationHelper
  def page_header(text)
    content_for(:page_header) { text.to_s }
  end

  # Gravatar helper: this method can be used anywhere in the app to display avatar of users
  def gravatar_for(user, size = 30, title = user.name)
    image_tag gravatar_image_url(user.email, size: size), title: title, class: 'img-rounded'
  end

  def gravatar_for_show(user, size = 140, title = user.name)
    image_tag gravatar_image_url(user.email, size: size), title: title, class: 'rounded-circle'
  end

  def gravatar_for_message(user, size = 40, title = user.name)
    image_tag gravatar_image_url(user.email, size: size), title: title, class: 'rounded-circle'
  end
end
