class CreateClinicProcedures < ActiveRecord::Migration[5.0]
  def change
    create_table :clinic_procedures do |t|
      t.integer :clinic_id
      t.integer :procedure_id
      t.string :description
      t.integer :duration
      t.timestamps
    end
    add_index :clinic_procedures, [:clinic_id, :procedure_id]
  end
end
