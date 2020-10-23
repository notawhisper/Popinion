class Post < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :content, presence: true, length: { in: 1..1000 }
end
