class CreateJoinTableShiftsUSers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :shifts, :users do |t|
      t.index :shift_id
      t.index :user_id
    end
  end
end
