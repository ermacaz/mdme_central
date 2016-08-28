class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.integer :patient_id
      t.string :token
      t.string :platform
      t.boolean :enabled, default: true
      t.timestamps
    end

    add_index :devices, :patient_id
  end
end
