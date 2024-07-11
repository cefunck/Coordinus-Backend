class CreateScheduleTimeRanges < ActiveRecord::Migration[7.1]
  def change
    create_table :schedule_time_ranges do |t|
      t.integer :start_time_hour
      t.integer :start_time_minute
      t.integer :end_time_hour
      t.integer :end_time_minute
      t.references :schedule_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
