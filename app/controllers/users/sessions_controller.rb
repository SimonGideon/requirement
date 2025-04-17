class Users::SessionsController < Devise::SessionsController
  def create
    # Find user by phone number or business name
    user = User.find_by(phone_number: params[:user][:phone_number]) ||
           User.find_by(business_name: params[:user][:business_name])

    if user && user.valid_password?(params[:user][:password])
      sign_in user
      redirect_to after_sign_in_path_for(user), notice: "Signed in successfully."
    else
      flash.now[:alert] = "Invalid login credentials."
      render :new
    end
  end

  private

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      client_dashboard_path
    end
  end
end
