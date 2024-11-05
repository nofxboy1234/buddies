class Book < ApplicationRecord
  belongs_to :author

  scope :with_id_greater_than, ->(id) { where("id > ?", id) }
end
