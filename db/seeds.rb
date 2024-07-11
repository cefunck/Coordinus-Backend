# create Users
users = [
  { name: "Ernesto" },
  { name: "Bárbara" },
  { name: "Benjamín" }
]

users.each do |user|
  User.find_or_create_by!(user)
end

# create client services
client_services = [
  { name: 'recorrido.cl' },
  { name: 'other_service.cl' }
]

client_services.each do |client_service|
  ClientService.find_or_create_by!(client_service)
end

# create schedule days
client_service = ClientService.first
schedule_days = [
  { day_of_week: :monday, client_service: client_service },
  { day_of_week: :tuesday, client_service: client_service },
  { day_of_week: :wednesday, client_service: client_service },
  { day_of_week: :thursday, client_service: client_service },
  { day_of_week: :friday, client_service: client_service },
  { day_of_week: :saturday, client_service: client_service },
  { day_of_week: :sunday, client_service: client_service }
]

schedule_days.each do |day|
  ScheduleDay.find_or_create_by!(day)
end

# create schedule time ranges of example (Monday to Friday)
(0..4).each do |day_of_week|
  schedule_day = ScheduleDay.find_by(day_of_week: day_of_week)
  schedule_time_range = {
    start_time_hour: 19,
    start_time_minute: 0,
    end_time_hour: 24,
    end_time_minute: 0,
    schedule_day: schedule_day
  }
  ScheduleTimeRange.find_or_create_by!(schedule_time_range)
end

# create schedule time ranges of example (Saturday and Sunday)
[5, 6].each do |day_of_week|
  schedule_day = ScheduleDay.find_by(day_of_week: day_of_week)
  schedule_time_range = {
    start_time_hour: 10,
    start_time_minute: 0,
    end_time_hour: 24,
    end_time_minute: 0,
    schedule_day: schedule_day
  }
  ScheduleTimeRange.find_or_create_by!(schedule_time_range)
end

# create unassigned shift with utc datetimes
shifts = [
  {
    user_time_zone: 'America/Santiago',
    start_time: DateTime.new(2020, 3, 2, 15, 0, 0),
    end_time: DateTime.new(2020, 3, 2, 16, 0, 0),
    client_service: ClientService.first,
  },
  {
    user_time_zone: 'America/Santiago',
    start_time: DateTime.new(2020, 3, 2, 14, 0, 0),
    end_time: DateTime.new(2020, 3, 2, 15, 0, 0),
    client_service: ClientService.first,
  },
  {
    user_time_zone: 'America/Santiago',
    start_time: DateTime.new(2020, 3, 3, 17, 0, 0),
    end_time: DateTime.new(2020, 3, 3, 18, 0, 0),
    client_service: ClientService.first,
  },
  {
    user_time_zone: 'America/Santiago',
    start_time: DateTime.new(2020, 3, 3, 14, 0, 0),
    end_time: DateTime.new(2020, 3, 3, 15, 0, 0),
    client_service: ClientService.first,
  }
]

shifts.each do |shift|
  Shift.find_or_create_by!(shift)
end

# mark all users as available for all shifts
Shift.all.each do |shift|
  shift.available_users = User.all
  shift.save!
end

# assign first user to all shifts
# user = User.first
# Shift.all.each do |shift|
#   shift.assigned_user = user
#   shift.save
# end
