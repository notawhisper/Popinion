class RechangeCodeNumbersToChatMember < ActiveRecord::Migration[5.2]
  def change
    rename_table :ChatMember, :chat_members
  end
end
