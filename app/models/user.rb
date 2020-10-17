class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  has_many :host_rooms, class_name: "Room", foreign_key: "host_id"
  has_many :chat_members, dependent: :destroy
  has_many :rooms, through: :chat_members, source: :room

  # def assign_code_number(room)
  #   if self == room.host
  #     code_number = 1
  #   else
  #     possible_number = [2..room.users.size] | room.code_numbers.pluck(:code_number)
  #     code_number = possible_number.sample
  #   end
  #
  #   self.code_numbers.create(room: room, code_number: code_number)
  # end
end
