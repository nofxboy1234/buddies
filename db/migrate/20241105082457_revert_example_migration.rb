require_relative "20241105080435_example_migration"

class RevertExampleMigration < ActiveRecord::Migration[7.2]
  def change
    revert ExampleMigration
  end
end
