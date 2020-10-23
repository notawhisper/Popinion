class ChatMember < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :code_number, numericality: { only_integer: true }, allow_nil: true
end
