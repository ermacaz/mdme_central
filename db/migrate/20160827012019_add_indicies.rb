class AddIndicies < ActiveRecord::Migration[5.0]
  def change
    add_index :patients, :email, :unique=>true
    add_index :doctors, :email, :unique=>true
    add_index :appointments, :doctor_id
    add_index :appointments, :patient_id
    add_index :appointments, :clinic_id
  end
end
