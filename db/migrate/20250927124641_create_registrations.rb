class CreateRegistrations < ActiveRecord::Migration[8.0]
  def change
    create_table :registrations do |t|
      t.integer :user_id,  null: false
      t.integer :event_id, null: false
      t.timestamps null: false
    end

    add_index :registrations, :user_id,  name: "index_registrations_on_user_id"
    add_index :registrations, :event_id, name: "index_registrations_on_event_id"

    add_foreign_key :registrations, :users,  column: :user_id
    add_foreign_key :registrations, :events, column: :event_id
  end
end
