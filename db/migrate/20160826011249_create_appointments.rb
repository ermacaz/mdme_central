class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.integer :clinic_id
      t.datetime :start_time
      t.text :description
      t.string  :status
      t.timestamps
    end
  end
end
