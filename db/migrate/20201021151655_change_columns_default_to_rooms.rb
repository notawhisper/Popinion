class ChangeColumnsDefaultToRooms < ActiveRecord::Migration[5.2]
  def change
    change_column_default :rooms, :let_guests_view_all, from: true, to: false
    change_column_default :rooms, :show_member_list, from: true, to: false
  end
end
