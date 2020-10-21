class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :group_memberships, class_name: "GroupMember", dependent: :destroy
  has_many :group_members, through: :group_memberships, source: :user
  has_many :rooms, dependent: :destroy

  def invite_group_member(user)
    self.group_memberships.create(user: user)
  end
end
