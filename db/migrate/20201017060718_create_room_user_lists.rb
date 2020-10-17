class CreateRoomUserLists < ActiveRecord::Migration[5.2]
  def change
    create_table :room_user_lists do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
