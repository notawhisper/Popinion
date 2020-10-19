class ChangeCodeNumbersToChatMember < ActiveRecord::Migration[5.2]
  def change
    rename_table :code_numbers, :ChatMember
  end
end
