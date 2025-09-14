class CreateUserSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :user_sessions, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: { index: true }
      t.text :ip_address
      t.text :user_agent
      t.timestamps
    end
  end
end
