class Users::PasswordsController < ApplicationController
  def new
    @user = User.new
  end

  def validate
    @user = User.find_by(phone_number: params[:user][:phone_number])

    if @user
      redirect_to security_user_password_path(phone_number: @user.phone_number)
    else
      flash.now[:alert] = "Phone number not found."
      render :new
    end
  end

  def security
    @user = User.find_by(phone_number: params[:phone_number])
    if @user.nil?
      redirect_to new_user_password_path, alert: "Invalid reset link."
    end
  end

  def verify
    @user = User.find_by(phone_number: params[:user][:phone_number])

    if @user && @user.security_answer.downcase == params[:user][:security_answer].downcase
      redirect_to change_user_password_path(phone_number: @user.phone_number)
    else
      flash.now[:alert] = "Incorrect security answer."
      render :security
    end
  end

  def change
    @user = User.find_by(phone_number: params[:phone_number])
    if @user.nil?
      redirect_to new_user_password_path, alert: "Invalid reset link."
    end
  end

  def update
    @user = User.find_by(phone_number: params[:user][:phone_number])

    if @user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      sign_in(@user)
      redirect_to after_resetting_password_path_for(@user), notice: "Your password has been changed successfully."
    else
      render :change
    end
  end

  private

  def after_resetting_password_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      client_dashboard_path
    end
  end
end
