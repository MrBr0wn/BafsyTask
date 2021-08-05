class UsersController < ApplicationController
  def signup
    render plain: "OK"
  end

  def registration
    @user = User.new(sign_up_params)

    if @user.save
      redirect_to root_path
    else
      redirect_to root_path, :flash => { :alert => "Registration error!" }
    end
  end

  def profile
    @user = current_user
  end

  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :patronymic, :gender, :email, :password, :password_confirmation)
  end
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :patronymic, :gender, :email, :password, :password_confirmation, :current_password)
  end
end