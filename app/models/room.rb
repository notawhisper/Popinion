class Room < ApplicationRecord
  belongs_to :host, class_name: "User"
  belongs_to :group, optional: true
  has_many :chat_memberships, class_name: "ChatMember", dependent: :destroy
  has_many :chat_members, through: :chat_memberships, source: :user
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { in: 1..30 }
  validates :description, length: { in: 0..200 }
  validates :distinguish_speaker, inclusion: { in: ["true", "false"] }
  validates :let_guests_view_all, inclusion: { in: ["true", "false"] }
  validates :show_member_list, inclusion: { in: ["true", "false"] }

  enum distinguish_speaker: { true: true, false: false }, _prefix: true
  enum let_guests_view_all: { true: true, false: false }, _prefix: true
  enum show_member_list: { true: true, false: false }, _prefix: true

  def invite_chat_member(user)
    self.chat_memberships.create(user: user)
  end

  def nullify_code_numbers
    self.chat_memberships.update_all(code_number: nil)
  end

  def assign_code_number
    max_number = self.chat_members.size

    self.chat_members.each do |user|
      if user == self.host
        self.chat_memberships.find_by(user_id: user.id).update_attribute(:code_number, 1)
      else
        possible_numbers = (2..max_number).to_a - self.chat_memberships.pluck(:code_number)
        code_number = possible_numbers.sample
        self.chat_memberships.find_by(user_id: user.id).update_attribute(:code_number, code_number)
      end
    end
    self.chat_memberships
  end
end
