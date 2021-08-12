require 'httparty'

class UsersController < ApplicationController
  def signup
    render plain: "OK"
  end

  def registration
    # TODO: сразу определить пол
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

  def confirm_gender
    @user = User.find(current_user.id)
    @current_date = DateTime.now
    if @user.update(confirmed_gender: true, gender_updated_at: @current_date)
      render json: {}, status: 200
    end
  end

  def update_gender
    if user_signed_in?
      @user = User.find(current_user.id)
      @user_name = User.get_full_name(@user)
      @gender = User.get_gender(@user_name) # TODO: над этим тоже подумать обновление/подтверждение
      if @user.update(gender: @gender, confirmed_gender: false)
        render json: { gender: @gender, status: "Пол (определён автоматически)" }, status: 200
      else
        render json: {}, status: 500
      end
    else
      redirect_to root_path, :flash => { :notice => "Nothing to run" }
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :patronymic,
                                 :gender,
                                 :email,
                                 :password,
                                 :password_confirmation
    )
  end

  def account_update_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :patronymic,
                                 :gender,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :current_password
    )
  end

end