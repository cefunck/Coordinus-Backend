class ScheduleDay < ApplicationRecord
  enum day_of_week: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  belongs_to :client_service
  has_many :schedule_time_ranges
end
