class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :patronymic, presence: true

  # getting the gender of a new User after registration
  after_create :update_user_gender


  # getting User gender over API Dadata
  def get_gender(name)
    data = [name].to_json

    headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Token #{Rails.application.credentials.dadata[:API_key]}",
        'X-Secret' => "#{Rails.application.credentials.dadata[:secret_key]}"
    }

    res = HTTParty.post(
        'https://cleaner.dadata.ru/api/v1/clean/name',
        :body => data,
        :headers => headers
    )
    res[0]["gender"]
  end

  # getting full name of User from object
  def get_full_name(obj)
    @full_name = "#{obj.last_name} #{obj.first_name} #{obj.patronymic}"
  end

  # getting the User from the db after updating,
  # building his full name,
  # getting his gender and update User with gender
  def update_user_gender
    @current_date = DateTime.now
    full_name = get_full_name(self)
    gender = get_gender(full_name)
    confirmed_gender = self.confirmed_gender
    self.update({ gender: gender, confirmed_gender: confirmed_gender, gender_updated_at: @current_date })
  end

end
