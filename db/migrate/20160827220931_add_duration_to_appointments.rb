class AddDurationToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :duration, :integer, default: 0
  end
end
