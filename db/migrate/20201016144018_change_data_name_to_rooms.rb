class ChangeDataNameToRooms < ActiveRecord::Migration[5.2]
  def up
    change_column :rooms, :name, :string
  end

  def down
    change_column :rooms, :name, :integer, using: 'name::integer'
  end
end
