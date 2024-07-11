class User < ApplicationRecord
    # has_many :shifts, inverse_of: 'assigned_user'
    has_many :assigned_shifts, class_name: 'Shift', foreign_key: 'assigned_user_id'
    has_and_belongs_to_many :available_shifts, class_name: 'Shift', join_table: 'shifts_users'
end
  
