module MessagesHelper
    #Display all users
  # def recipients_options(chosen_recipient = nil)
  #   s = ''
  #   User.all.each do |user|
  #     s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}' #{'selected' if user == chosen_recipient}>#{user.first_name} #{user.last_name}</option>"
  #     end
  #   s.html_safe
  # end

    #Display only buddies of the current user in the selection of recipients
    def recipients_options(chosen_recipient = nil)
      if user_signed_in?
        s = ''
        current_user.friends.each do |user|
          s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}' #{'selected' if user == chosen_recipient}>#{user.first_name} #{user.last_name}</option>"
          end
        s.html_safe
      end
    end
end
