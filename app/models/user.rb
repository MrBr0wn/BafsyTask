class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :patronymic, presence: true

  private

  # getting gender of user over API Dadata
  def self.get_gender(name)
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

  # getting full name of user from object
  def self.get_full_name(obj)
    @full_name = "#{obj.last_name} #{obj.first_name} #{obj.patronymic}"
  end
end
