class AddSexAndMaritalStatusToPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :sex, :integer
    add_column :patients, :marital_status, :integer
  end
end
