# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160831003719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.integer  "clinic_id"
    t.datetime "start_time"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "duration",    default: 0
    t.index ["clinic_id"], name: "index_appointments_on_clinic_id", using: :btree
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id", using: :btree
    t.index ["patient_id"], name: "index_appointments_on_patient_id", using: :btree
  end

  create_table "appointments_clinic_procedures", force: :cascade do |t|
    t.integer  "appointment_id"
    t.integer  "clinic_procedure_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["appointment_id"], name: "index_appointments_clinic_procedures_on_appointment_id", using: :btree
    t.index ["clinic_procedure_id"], name: "index_appointments_clinic_procedures_on_clinic_procedure_id", using: :btree
  end

  create_table "clinic_procedures", force: :cascade do |t|
    t.integer  "clinic_id"
    t.integer  "procedure_id"
    t.string   "description"
    t.integer  "duration"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["clinic_id", "procedure_id"], name: "index_clinic_procedures_on_clinic_id_and_procedure_id", using: :btree
  end

  create_table "clinics", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.string   "phone_number"
    t.string   "fax_umber"
    t.float    "ne_latitude"
    t.float    "ne_longitude"
    t.float    "sw_latitude"
    t.float    "sw_longitude"
    t.string   "timezone"
    t.string   "sunday_open_time"
    t.string   "sunday_close_time"
    t.boolean  "is_open_sunday"
    t.string   "monday_open_time"
    t.string   "monday_close_time"
    t.boolean  "is_open_monday"
    t.string   "tuesday_open_time"
    t.string   "tuesday_close_time"
    t.boolean  "is_open_tuesday"
    t.string   "wednesday_open_time"
    t.string   "wednesday_close_time"
    t.boolean  "is_open_wednesday"
    t.string   "thursday_open_time"
    t.string   "thursday_close_time"
    t.boolean  "is_open_thursday"
    t.string   "friday_open_time"
    t.string   "friday_close_time"
    t.boolean  "is_open_friday"
    t.string   "saturday_open_time"
    t.string   "saturday_close_time"
    t.boolean  "is_open_saturday"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "clinics_doctors", id: false, force: :cascade do |t|
    t.integer "clinic_id"
    t.integer "doctor_id"
    t.index ["clinic_id"], name: "index_clinics_doctors_on_clinic_id", using: :btree
    t.index ["doctor_id"], name: "index_clinics_doctors_on_doctor_id", using: :btree
  end

  create_table "clinics_patients", id: false, force: :cascade do |t|
    t.integer "clinic_id"
    t.integer "patient_id"
    t.index ["clinic_id"], name: "index_clinics_patients_on_clinic_id", using: :btree
    t.index ["patient_id"], name: "index_clinics_patients_on_patient_id", using: :btree
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "token"
    t.string   "platform"
    t.boolean  "enabled",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["patient_id"], name: "index_devices_on_patient_id", using: :btree
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_doctors_on_email", unique: true, using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "api_key"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.date     "birthday"
    t.string   "name_prefix"
    t.string   "name_suffix"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "sex"
    t.integer  "marital_status"
    t.index ["email"], name: "index_patients_on_email", unique: true, using: :btree
  end

  create_table "procedures", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "duration",    default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "procedures_symptoms", force: :cascade do |t|
    t.integer  "procedure_id"
    t.integer  "symptom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "symptoms", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
