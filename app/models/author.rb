class Author < ApplicationRecord
  has_many :books, -> { order(id: :desc) }
  # dependent: :destroy
end
