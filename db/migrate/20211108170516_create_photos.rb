class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :photographer, null: false
      t.references :category, null: false
      t.text :image_data
      t.integer :likes_count, default: 0
      t.integer :views_count, default: 0
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
