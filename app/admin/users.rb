ActiveAdmin.register User do

  after_update :get_gender

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name,
                :last_name,
                :patronymic,
                :email,
                :gender,
                :gender_updated_at,
                :confirmed_gender,
                :encrypted_password,
                :reset_password_token,
                :reset_password_sent_at,
                :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # Form page
  form do |f|

    f.inputs do
      f.input :last_name
      f.input :first_name
      f.input :patronymic
      f.input :email
      f.input :gender
      f.input :confirmed_gender
    end

    f.actions
  end

  controller do

    def get_gender(name)
      full_name = "#{params[:user][:last_name]} #{params[:user][:first_name]} #{params[:user][:patronymic]}"
      data = [full_name].to_json
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

      @user = User.find(params[:id])
      @user.update(gender: res[0]["gender"])
    end
  end
  
end
