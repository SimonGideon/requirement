class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :business_name,
      :phone_number,
      :password,
      :password_confirmation,
      :security_question,
      :security_answer,
      :role,
      :client_id
    ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :business_name,
      :password,
      :password_confirmation,
      :current_password,
      :security_question,
      :security_answer,
      :role,
      :client_id
    ])
  end

  def after_sign_up_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      client_dashboard_path
    end
  end
end
