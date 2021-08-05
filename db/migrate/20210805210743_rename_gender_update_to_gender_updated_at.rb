class RenameGenderUpdateToGenderUpdatedAt < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :gender_update, :gender_updated_at
  end
end
