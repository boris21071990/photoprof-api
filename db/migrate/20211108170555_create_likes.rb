class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :photographer, null: false
      t.references :photo, null: false

      t.timestamps
    end
  end
end
