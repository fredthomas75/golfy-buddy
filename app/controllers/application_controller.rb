class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_number_unread_messages, if: :user_signed_in?

  # def configure_permitted_parameters
  #   # For additional fields in app/views/devise/registrations/new.html.erb
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [
  #     :name,
  #     :first_name,
  #     :last_name,
  #     :birth_date,
  #     :gender,
  #     :handicap,
  #     :pro,
  #     :about_me,
  #     :photo,
  #     :current_city,
  #     :language,
  #     :list_pref_ids
  #   ])

  #   # For additional in app/views/devise/registrations/edit.html.erb
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :last_name, :phone, :birth_date, :gender, :country, :handicap, :pro, :about_me, :photo])
  # end

  rescue_from ActiveRecord::RecordNotFound do
  flash[:warning] = 'Resource not found.'
  redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  # Set @admin which is used to send messages ans notifications
  def set_admin_gb
    @admin = User.find_by(email: 'info@golfybuddy.com')
  end

  def set_number_unread_messages
    # @unread_conversations_count = current_user.mailbox.conversations.unread(current_user).count
  end
end
