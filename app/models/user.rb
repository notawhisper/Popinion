class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { in: 1..20 }

  has_many :host_rooms, class_name: "Room", foreign_key: "host_id", dependent: :destroy
  has_many :chat_memberships, class_name: "ChatMember", dependent: :destroy
  has_many :rooms, through: :chat_memberships, source: :room
  has_many :posts, dependent: :destroy
  has_many :own_groups, class_name: "Group", foreign_key: "owner_id", dependent: :destroy
  has_many :group_memberships, class_name: "GroupMember", dependent: :destroy
  has_many :groups, through: :group_memberships, source: :group

  def current_code_number(room)
    self.chat_memberships.find_by(room_id: room.id).code_number
  end
end
