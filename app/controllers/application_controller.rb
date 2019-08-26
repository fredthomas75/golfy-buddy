class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name, :phone, :birth_date, :gender, :language, :current_city, :handicap, :about_me])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :last_name, :phone, :birth_date, :gender, :language, :current_city, :handicap, :about_me])
  end

  rescue_from ActiveRecord::RecordNotFound do
  flash[:warning] = 'Resource not found.'
  redirect_back_or root_path
  end

  def redirect_back_or(path)
  redirect_to request.referer || path
  end
end
