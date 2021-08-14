require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(first_name: "First_name",
                        last_name: "Last_name",
                        patronymic: "Patronymic",
                        email: "email@example.com",
                        password: "password"
    )
  }

  let (:full_name) { "#{subject.last_name} #{subject.first_name} #{subject.patronymic}" }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should be not valid without a first name' do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it 'should be not valid without a last name' do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it 'should be not valid without a patronymic' do
    subject.patronymic = nil
    expect(subject).to_not be_valid
  end

  it 'should be not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'should be not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  describe "Methods:" do
    it 'method get_full_name should be return full name of user' do
      expect(User.get_full_name(subject)).to eq(full_name)
    end

    it 'method get_full_name should be not valid if empty' do
      # subject.last_name = ""
      # subject.first_name = ""
      # subject.patronymic = ""
      full_name = User.get_full_name(subject).delete(" ")
      expect(full_name.delete(" ")).to_not be_empty
    end

    it 'method get_gender should be not valid if empty' do
      expect(User.get_gender(full_name)).to_not be_empty
    end

    it 'method get_gender should be return М/Ж/НД' do
      expect(User.get_gender(full_name)).to eq('М').or eq('Ж').or eq('НД')
    end
  end

end
