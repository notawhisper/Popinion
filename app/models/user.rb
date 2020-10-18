class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  has_many :host_rooms, class_name: "Room", foreign_key: "host_id"
  has_many :chat_memberships, class_name: "ChatMember", dependent: :destroy
  has_many :rooms, through: :chat_memberships, source: :room

  # def assign_code_number(room)
  #   if self == room.host
  #     code_number = 1
  #   else
  #     possible_number = [2..room.users.size] | room.chat_members.pluck(:code_number)
  #     code_number = possible_number.sample
  #   end
  #
  #   self.chat_members.create(room: room, code_number: code_number)
  # end
end
