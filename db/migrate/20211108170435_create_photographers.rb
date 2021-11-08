class CreatePhotographers < ActiveRecord::Migration[6.1]
  def change
    create_table :photographers do |t|
      t.references :user, null: false
      t.references :city, null: false
      t.string :first_name
      t.string :last_name
      t.string :slug, index: { unique: true }
      t.text :image_data
      t.text :description
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
