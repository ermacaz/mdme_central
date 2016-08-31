class CreateAppointmentClinicProcedures < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments_clinic_procedures do |t|
      t.integer :appointment_id
      t.integer :clinic_procedure_id
      t.timestamps
    end
    add_index :appointments_clinic_procedures, :appointment_id
    add_index :appointments_clinic_procedures, :clinic_procedure_id
  end
end
