class Room < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :chat_memberships, class_name: "ChatMember", dependent: :destroy
  has_many :chat_members, through: :chat_memberships, source: :user
  has_many :posts

  def invite_chat_member(user)
    self.chat_memberships.create(user: user)
  end

  def nullify_code_numbers
    self.chat_memberships.update_all(code_number: nil)
  end

  def assign_code_number
    self.nullify_code_numbers
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
