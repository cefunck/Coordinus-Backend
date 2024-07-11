class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts do |t|
      t.string :user_time_zone
      t.datetime :start_time
      t.datetime :end_time
      t.references :client_service, null: false, foreign_key: true
      t.references :assigned_user, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
