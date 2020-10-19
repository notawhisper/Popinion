class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :name,                null: false
      t.text :description
      t.integer :group_id
      t.boolean :distinguish_speaker, null: false, default: false
      t.boolean :let_guests_view_all, null: false, default: true
      t.boolean :show_member_list,    null: false, default: true

      t.timestamps
    end
  end
end
