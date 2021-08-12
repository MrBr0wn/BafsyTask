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
    # TODO: ключи убрать credentials
    headers = {
        'Content-Type' => 'application/json',
        'Authorization' => 'Token 74e8c41778bbdc70dc29d19fe2907c83bdc9dc02',
        'X-Secret' => '1fd705589302da6ff54d5f43868925d22c2345e3'
    }

    res = HTTParty.post(
        'https://cleaner.dadata.ru/api/v1/clean/name',
        :body => data,
        :headers => headers
    )
    res[0]["gender"]
  end

  # getting full name of user from object
  # TODO: Написать тест для этого метода
  def self.get_full_name(obj)
    @full_name = "#{obj.last_name} #{obj.first_name} #{obj.patronymic}"
  end
end
