ActiveAdmin.register User do

  after_update :update_user_gender

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

    def update_user_gender(id)
      User.update_user_gender(params[:id])
    end
  end
  
end
