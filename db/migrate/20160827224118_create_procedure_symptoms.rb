class CreateProcedureSymptoms < ActiveRecord::Migration[5.0]
  def change
    create_table :procedure_symptoms do |t|
      t.integer :procedure_id
      t.integer :symtpom_id
      t.string  :description
      t.timestamps
    end
  end
end
