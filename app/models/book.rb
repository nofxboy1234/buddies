class Book < ApplicationRecord
  belongs_to :author

  scope :with_id_greater_than, ->(id) { where("id > ?", id) }

  def hello
    puts "hello"
  end

  def self.bye
    puts "bye"
  end
end
