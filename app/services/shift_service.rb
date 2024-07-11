class ShiftService < PowerTypes::Service.new()
    def get_week_optimal_shift_assignations(week_shifts)
        GetOptimalShiftsAssignations.for(shifts: formatted(week_shifts))
    end

    def save_week_assigation(week_assignation)
        ActiveRecord::Base.transaction do
            week_assignation.each do |assignation|
                shift = Shift.find(assignation[:shift_id])
                user = User.find(assignation[:user_id])
                shift.assigned_user = user
                shift.save!
            end
        end
    end

    def get_grouped_shifts_by_day(week_shifts)
        week_shifts.group_by { |shift| shift.day_of_week }
    end

    private

    def formatted(week_shifts)
        result = []
        shifts_by_day = get_grouped_shifts_by_day(week_shifts)
        shifts_by_day.each do |day, shifts|
            ordered_shifts = shifts.sort_by { |shift| shift.start_time }
            ordered_shifts.each_with_index do |shift, index|
                result << {
                    shift_id: shift.id,
                    shift_index_in_day: index,
                    day_of_week: day,
                    available_users_ids: shift.available_users_ids
                }
            end
        end
        result.flatten
    end
end