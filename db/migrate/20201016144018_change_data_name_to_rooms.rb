class ChangeDataNameToRooms < ActiveRecord::Migration[5.2]
  def change
    change_column :rooms, :name, :string
  end
end
