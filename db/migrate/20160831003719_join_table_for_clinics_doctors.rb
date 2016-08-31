class JoinTableForClinicsDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :clinics_doctors, id: false do |t|
      t.integer :clinic_id
      t.integer :doctor_id
    end

    add_index :clinics_doctors, :clinic_id
    add_index :clinics_doctors, :doctor_id
  end
end
