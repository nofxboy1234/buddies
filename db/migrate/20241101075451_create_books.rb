class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.references :author, null: false, foreign_key: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
