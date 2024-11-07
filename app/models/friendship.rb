class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :today, -> { where("created_at > ?", Time.now.midnight) }
end
