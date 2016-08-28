class CreateProcedures < ActiveRecord::Migration[5.0]
  def change
    create_table :procedures do |t|
      t.string :name
      t.string :description
      t.integer :duration, default: 0
      t.timestamps
    end
  end
end
