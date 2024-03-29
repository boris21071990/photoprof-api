class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :role, limit: 1
      t.string :email, index: { unique: true }
      t.string :password_digest

      t.timestamps
    end
  end
end
