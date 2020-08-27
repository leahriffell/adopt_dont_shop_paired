class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pets, :favorites, :is_favorite
  end
end
