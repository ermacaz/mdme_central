class CreateClinics < ActiveRecord::Migration[5.0]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :phone_number
      t.string :fax_umber
      t.float :ne_latitude
      t.float :ne_longitude
      t.float :sw_latitude
      t.float :sw_longitude
      t.string :timezone
      t.string :sunday_open_time
      t.string :sunday_close_time
      t.boolean :is_open_sunday
      t.string :monday_open_time
      t.string :monday_close_time
      t.boolean :is_open_monday
      t.string :tuesday_open_time
      t.string :tuesday_close_time
      t.boolean :is_open_tuesday
      t.string :wednesday_open_time
      t.string :wednesday_close_time
      t.boolean :is_open_wednesday
      t.string :thursday_open_time
      t.string :thursday_close_time
      t.boolean :is_open_thursday
      t.string :friday_open_time
      t.string :friday_close_time
      t.boolean :is_open_friday
      t.string :saturday_open_time
      t.string :saturday_close_time
      t.boolean :is_open_saturday
      t.timestamps
    end
  end
end
