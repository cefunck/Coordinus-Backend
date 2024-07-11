class GetOptimalShiftsAssignations < PowerTypes::Command.new(:shifts)
    # TODO: refactorizar para lograr calidad de codigo.
    # input: shift ordenados de la semana a calcular en el siguiente formato
    def perform
      return @shifts if !@shifts.present?
      shifts = get_grouped_shifts_per_day(@shifts)
      shifts = ordered_day_shifts(shifts)
      combinations = week_worker_combinations(shifts)
      potential_weeks = potential_weeks(combinations)
      potential_weeks_total_shift_changes = potential_weeks.map { |week| week_total_shifts_changes(week) }
      potential_weeks_total_standar_deviations = potential_weeks.map { |week| week_total_shifts_standard_deviations(week) }
      item, index = potential_weeks.each_with_index.min_by do |item, index|
          max_shift_changes = potential_weeks_total_shift_changes.max
          current_shift_changes = potential_weeks_total_shift_changes[index]
          max_standard_deviation = potential_weeks_total_standar_deviations.max
          current_standar_deviation = potential_weeks_total_standar_deviations[index]
          0.5 * normalization(current_shift_changes, max_shift_changes) + 0.5 * normalization(current_standar_deviation, max_standard_deviation)
      end
      # la combinación optima semanal de combinacinones de trabajadores para cada día
      output = item.values.flatten.map { |shift| { shift_id: shift[:shift_id], user_id: shift[:user_id] } }
      output
    end

    private

    def get_grouped_shifts_per_day(shifts)
        # Creamos un hash para almacenar los shifts agrupados por day_of_week
        grouped_shifts_per_day = {}
      
        # Iteramos sobre cada shift en el array dado
        shifts.each do |shift|
          day_of_week = shift[:day_of_week]
          
          # Si todavía no existe una entrada para este día de la semana, la creamos
          grouped_shifts_per_day[day_of_week] ||= []
          
          # Añadimos el shift al array correspondiente
          grouped_shifts_per_day[day_of_week] << {
            shift_id: shift[:shift_id],
            shift_index_in_day: shift[:shift_index_in_day],
            available_users_ids: shift[:available_users_ids]
          }
        end
        # devolvemos los turnos agrupados por día
        grouped_shifts_per_day
    end
    
    def ordered_day_shifts(shifts_per_day)
        # Ordenamos cada array de shifts dentro del hash por shift_index_in_day
        shifts_per_day.each do |day_of_week, shifts|
            shifts_per_day[day_of_week] = shifts.sort_by { |shift| shift[:shift_index_in_day] }
        end
    
        # Devolvemos los shift ordenados dentro de cada día
        shifts_per_day
    end
    
    # Función para obtener todas las combinaciones de selección de user_id para cada shift
    def day_workers_combinations(shifts, index = 0, current_combination = [], result = [])
        if index == shifts.size
          result << current_combination.dup
          return
        end
      
        shift = shifts[index]
    
        shift[:available_users_ids].each do |user_id|
          current_combination << { shift_index_in_day: shift[:shift_index_in_day], shift_id: shift[:shift_id], user_id: user_id }
          day_workers_combinations(shifts, index + 1, current_combination, result)
          current_combination.pop
        end
      
        result
    end
    
    # para cada día obtener:
    # las combinaciones de trabajadores
    def week_worker_combinations(week_shifts)
        days = week_shifts.keys
        workers_combinations = week_shifts.values.map {|data| day_workers_combinations(data)}
        days.zip(workers_combinations).to_h
    end
    
    # obtener cada posible semana
    def potential_weeks_old(data)
        days = data.keys
        values = data.values.map(&:dup) # Copiar los arrays de elementos para no modificar los datos originales
        
        # Obtener todas las combinaciones usando product
        combinations = days.map { |day| values.shift.map { |element| { day => element } } }.inject(&:product).map { |arr| arr.reduce({}, :merge) }
        
        # Ahora 'combinations' tiene todas las combinaciones posibles con el día como llave
        asd = combinations.map do |combination|
            combination
        end
    
    
        asd
    end
    
    def potential_weeks(schedule)
        days = schedule.keys
        # Generate all combinations of shifts for each day
        day_combinations = days.map { |day| schedule[day] }
        # Calculate the Cartesian product of the combinations for each day
        cartesian_product = day_combinations.shift.product(*day_combinations)
      
        # Map the Cartesian product into the desired format
        combinations = cartesian_product.map do |combination|
          result = {}
          days.each_with_index do |day, index|
            result[day] = combination[index]
          end
          result
        end
      
        combinations
      end
    
    # para cada posible semana obtener:
    # los cambios totales de la semana
    def users_chain(combination)
        combination.map {|c| c[:user_id]}
    end
    
    def total_shift_changes(users_chain)
        changes = 0
        (0...users_chain.length - 1).each do |i|
          if users_chain[i] != users_chain[i + 1]
            changes += 1
          end
        end
        changes
    end
    
    def week_total_shifts_changes(week)
        days_shifts_user_chains = week.values.map{ |day_shifts| users_chain(day_shifts) }
        days_shift_changes = days_shifts_user_chains.map { |day_shifts_user_chains| total_shift_changes(day_shifts_user_chains) }
        days_shift_changes.sum
    end
    
    # las horas totales de cada trabajador
    def total_worker_hours(users_chain)
        total_hours = Hash.new(0) # Inicializamos el hash con un valor predeterminado de 0
        
        users_chain.each do |user_id|
            total_hours[:user_id] = user_id
            total_hours[:total_hours] += 1
        end
        
        total_hours
    end
    
    def standard_deviation(numbers)
        # calculate the mean
        mean = numbers.sum(0.0) / numbers.size
        # calculate the sum of the squares of the differences with the mean
        sum_of_squares = numbers.map { |value| (value - mean) ** 2 }.sum
        # calculate the std dev
        Math.sqrt(sum_of_squares / (numbers.size - 1))
    end
    
    def week_total_shifts_standard_deviations(week)
        days_shifts_user_chains = week.values.map{ |day_shifts| users_chain(day_shifts) }
        days_shift_total_worker_hours = days_shifts_user_chains.map { |day_shifts_user_chains| total_worker_hours(day_shifts_user_chains) }
        users_ids = [1,2,3]
        ids = users_ids.select do |user_id|
            ids = days_shift_total_worker_hours.map do |x|
                x[:user_id]
            end
            !ids.include?(user_id)
        end
        ids.each { |user_id| days_shift_total_worker_hours << { user_id: user_id, total_hours: 0 } }
        days_shift_total_worker_hours.sort_by! {|item| item[:user_id]}
        total_hours = days_shift_total_worker_hours.map { |item| item[:total_hours] }
        standard_deviation(total_hours)
    end
    
    def normalization(number, max, min = 0)
        return 0 if max.zero?
    
        (number.to_f - min)/max
    end
  end





