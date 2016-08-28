class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :api_key
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :work_phone
      t.string :home_phone
      t.string :mobile_phone
      t.date :birthday
      t.string :name_prefix
      t.string :name_suffix
      t.timestamps
    end
  end
end
