class CreateClientServices < ActiveRecord::Migration[7.1]
  def change
    create_table :client_services do |t|
      t.string :name

      t.timestamps
    end
  end
end
