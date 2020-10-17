class Room < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :chat_members, dependent: :destroy
  has_many :users, through: :chat_members, source: :user

  def invite_member(user)
    room_user_lists.create(user: user)
  end
end
