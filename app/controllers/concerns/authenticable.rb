module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def current_user
    @current_user ||= super
  end

  def require_admin!
    return if current_user&.role_admin?

    flash[:alert] = 'You must be an admin to access this page.'
    redirect_to root_path
  end

  def require_client!
    return if current_user&.role_client?

    flash[:alert] = 'You must be a client to access this page.'
    redirect_to root_path
  end
end 