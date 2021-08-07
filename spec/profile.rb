require 'rails_helper'

RSpec.describe "profile page" do
  it "show home page" do
    visit "/"
    expect(page).to have_content "Сервис автоматического определения пола пользователя"
  end
end