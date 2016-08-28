class CreateAppointmentClinicProcedures < ActiveRecord::Migration[5.0]
  def change
    create_table :appointment_clinic_procedures do |t|
      t.integer :appointment_id
      t.intger :clinic_procedure_id
      t.timestamps
    end
    add_index :appointment_clinic_procedures, [:appointment_id, :clinic_procedure_id]
  end
end
