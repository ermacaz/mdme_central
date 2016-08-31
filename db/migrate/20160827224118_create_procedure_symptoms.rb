class CreateProcedureSymptoms < ActiveRecord::Migration[5.0]
  def change
    create_table :procedures_symptoms do |t|
      t.integer :procedure_id
      t.integer :symptom_id
      t.timestamps
    end
  end
end
