require 'httparty'

class UsersController < ApplicationController
  def signup
    render plain: "OK"
  end

  def registration
    # сразу определить пол
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
      @user_name = "{#{@user.last_name} #{@user.first_name} #{@user.patronymic}}" # убрать в модель и написать тест
      @gender = get_gender(@user_name) # над этим тоже подумать обновление/подтверждение
      if @user.update(gender: @gender, confirmed_gender: false)
        render json: { gender: @gender, status: "Пол (определён автоматически)" }, status: 200
      else
        render json: {}, status: 500
      end
    else
      redirect_to root_path, :flash => { :notice => "Nothing run" }
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :patronymic, :gender, :email, :password, :password_confirmation)
  end
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :patronymic, :gender, :email, :password, :password_confirmation, :current_password)
  end

  # TODO: перенести в метод отдельный
  def get_gender(name)
    data = [name].to_json
    # ключи убрать
    headers = {
                   'Content-Type' => 'application/json',
                   'Authorization' => 'Token 69129f79ee2f6e99f8ee3b583f0f7d61ec5fbc25',
                   'X-Secret' => '375cfb0bff7a081ea782a50d88c8a6be8ac73521'
    }

    res = HTTParty.post(
        'https://cleaner.dadata.ru/api/v1/clean/name',
        :body => data,
        :headers => headers
    )
    res[0]["gender"]
  end
end