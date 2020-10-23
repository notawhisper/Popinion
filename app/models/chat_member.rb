class ChatMember < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :code_name, numericality: { only_integer: true }
end
