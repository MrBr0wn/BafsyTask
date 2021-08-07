class AddConfirmedGenderFieldToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :confirmed_gender, :boolean
  end
end
