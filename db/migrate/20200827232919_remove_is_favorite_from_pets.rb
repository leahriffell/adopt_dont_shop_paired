class RemoveIsFavoriteFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :is_favorite, :boolean
  end
end
