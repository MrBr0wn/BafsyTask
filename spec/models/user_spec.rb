require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Registration' do

    let!(:user) { create(:user, email: "user@example.ru", password: "password") }

    before(:each) do
      login("user@example.ru", "password")
    end

  end
end
