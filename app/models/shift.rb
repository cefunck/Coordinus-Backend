class Shift < ApplicationRecord
  belongs_to :client_service
  belongs_to :assigned_user, class_name: 'User', foreign_key: 'assigned_user_id', optional: true
  has_and_belongs_to_many :available_users, class_name: 'User', join_table: 'shifts_users'

  def self.in_week(week_number, year)
    start_date = Date.commercial(year, week_number, 1)
    end_date = Date.commercial(year, week_number, 7)
    where(start_time: start_date.beginning_of_day..end_date.end_of_day)
  end

  def year
    self.start_time.in_time_zone(self.user_time_zone).year
  end

  def week_number
    self.start_time.in_time_zone(self.user_time_zone).strftime("%V").to_i
  end

  def time_range
    start_time = self.start_time.in_time_zone(self.user_time_zone).strftime('%H:%M')
    end_time = self.end_time.in_time_zone(self.user_time_zone).strftime('%H:%M')
    "#{start_time}-#{end_time}"
  end

  def day_of_week
    self.start_time.in_time_zone(self.user_time_zone).strftime('%A').downcase.to_sym
  end

  def available_users_ids
    self.available_users.pluck(:id)
  end

end
