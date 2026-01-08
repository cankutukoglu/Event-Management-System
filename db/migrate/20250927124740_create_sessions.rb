class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string  :ip_address
      t.string  :user_agent
      t.timestamps null: false
    end

    add_index :sessions, :user_id, name: "index_sessions_on_user_id"
    add_foreign_key :sessions, :users, column: :user_id
  end
end
