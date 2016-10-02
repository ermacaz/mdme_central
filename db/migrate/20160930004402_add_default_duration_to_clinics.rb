class AddDefaultDurationToClinics < ActiveRecord::Migration[5.0]
  def change
    add_column :clinics, :default_duration, :integer
  end
end
