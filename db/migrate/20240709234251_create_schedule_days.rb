class CreateScheduleDays < ActiveRecord::Migration[7.1]
  def change
    create_table :schedule_days do |t|
      t.integer :day_of_week
      t.references :client_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
