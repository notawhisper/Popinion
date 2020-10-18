class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :chat_members, :code_number, :integer, null: true
  end

  def down
    change_column :chat_members, :code_number, :integer, null: false
  end
end
