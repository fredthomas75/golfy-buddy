# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |resource|
      Wishlist.create!(user: resource)
      perso_id = params["user"]["list_pref_ids"]
      list = perso_id.map do |id|
        if !id.blank?
          ListPref.find(id)
        end
      end
      list.each do |l|
        if !l.nil?
          UserPreference.create!(user: resource, list_pref: l)
        end
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super do |resource|
      perso_id = params["user"]["list_pref_ids"]
      list = perso_id.map do |id|
        if !id.blank?
          ListPref.find(id)
        end
      end
      list.each do |l|
        if !l.nil?
          UserPreference.create!(user: resource, list_pref: l)
        end
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name,
      :last_name,
      :birth_date,
      :gender,
      :handicap,
      :pro,
      :about_me,
      :photo,
      :current_city,
      :list_pref_ids,
      :language
    ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name,
      :last_name,
      :birth_date,
      :gender,
      :handicap,
      :pro,
      :about_me,
      :photo,
      :current_city,
      :list_pref_ids,
      :language
    ])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
