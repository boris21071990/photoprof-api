class CreateViews < ActiveRecord::Migration[6.1]
  def change
    create_table :views do |t|
      t.references :viewable, polymorphic: true, null: false
      t.date :view_date
      t.string :view_hash

      t.timestamps
    end
  end
end
