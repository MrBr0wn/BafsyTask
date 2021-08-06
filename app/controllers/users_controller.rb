require 'httparty'

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

  def update_gender
    if user_signed_in?
      # respond_to do |format|
      #   if @appointment.save
      #     AppointmentMailer.with(client: @appointment).send_to_client.deliver_later
      #     AppointmentMailer.with(company: @appointment).send_to_company.deliver_later
      #     session[@appointment.news_id] = "sended"
      #     format.html
      #     format.js
      #   else
      #     format.html { redirect_to "/404" }
      #   end
      # end
      @user_name = "{#{current_user.last_name} #{current_user.first_name} #{current_user.patronymic}}"
      @gender = get_gender(@user_name)
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

  def get_gender(name)
    data = [name].to_json
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
    res = res[0]["gender"]
  end
end