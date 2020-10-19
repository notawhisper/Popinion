class AddHostIdToRooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :host, foreign_key: { to_table: :users }, index: false, null: false
  end
end
