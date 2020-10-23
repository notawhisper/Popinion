class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :group_memberships, class_name: "GroupMember", dependent: :destroy
  has_many :group_members, through: :group_memberships, source: :user
  has_many :rooms, dependent: :destroy

  validates :name, presence: true, length: { in: 1..30 }
  validates :description, length: { in: 0..300 }

  def invite_group_member(user)
    self.group_memberships.create(user: user)
  end
end
