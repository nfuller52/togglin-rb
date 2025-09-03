class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.citext :email, null: false
      t.text :password_digest, null: false
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.datetime :reset_password_sent_at
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
