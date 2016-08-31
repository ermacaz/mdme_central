namespace :db do
  desc 'Fill with sample data'
  task populate: :environment do
    puts 'Creating Clinics'
    c1 = Clinic.create!(name: 'MGH',
                       address: '55 Fruit Street|9th floor',
                       city:     'Boston',
                       state:    'Ma',
                       zipcode:  '02114',
                       country:  'United States',
                       is_open_sunday: false,
                       is_open_monday: true,
                       is_open_tuesday: true,
                       is_open_wednesday: true,
                       is_open_thursday: true,
                       is_open_friday: true,
                       is_open_saturday: false,
                       monday_open_time: '8:00 AM',
                       monday_close_time: '4:00PM',
                       tuesday_open_time: '8:00 AM',
                       tuesday_close_time: '4:00PM',
                       wednesday_open_time: '8:00 AM',
                       wednesday_close_time: '4:00PM',
                       thursday_open_time: '8:00 AM',
                       thursday_close_time: '4:00PM',
                       friday_open_time: '8:00 AM',
                       friday_close_time: '4:00PM')

    3.times do |n|
      c = Clinic.create!(name: 'MGH',
                         address: "#{Faker::Address.street_address}|#{Faker::Address.secondary_address}",
                         city:     'Phoenix',
                         state:    'AZ',
                         zipcode:  '85018',
                         country:  'United States',
                         is_open_sunday: false,
                         is_open_monday: true,
                         is_open_tuesday: true,
                         is_open_wednesday: true,
                         is_open_thursday: true,
                         is_open_friday: true,
                         is_open_saturday: false,
                         monday_open_time: '8:00 AM',
                         monday_close_time: '4:00PM',
                         tuesday_open_time: '8:00 AM',
                         tuesday_close_time: '4:00PM',
                         wednesday_open_time: '8:00 AM',
                         wednesday_close_time: '4:00PM',
                         thursday_open_time: '8:00 AM',
                         thursday_close_time: '4:00PM',
                         friday_open_time: '8:00 AM',
                         friday_close_time: '4:00PM')

    end
    puts 'Creating first patient'
    p = Patient.create!(first_name: 'John',
                        last_name: 'Doeseph',
                        email: 'user@example.com',
                        password: 'Qwerty123!',
                        password_confirmation: 'Qwerty123!',
                        sex: :male,
                        marital_status: :single,
                        address: '1324 W 4th street|4C',
                        city: 'phoenix',
                        state: 'AZ',
                        zipcode: '85018',
                        birthday: Date.today - 25.years)
    p.clinics << c1
    d1 = Doctor.create!(first_name: 'Heath',
                   last_name: 'Skylord',
                   email: 'doctor@example.com',
                   password: 'AndrewMattMDME3000!',
                   password_confirmation: 'AndrewMattMDME3000!',
                   phone_number: '121-124-6722'
    )
    d1.clinics << c1
    puts 'creating procedures and symptoms'
    procedures = []
    fever = Symptom.create!(:name=>'Fever', :description=>'High body temperature (>99F)')
    apain = Symptom.create!(:name=>'Abdominal pain', :description=>'Non-gastrointestinal pain below the ribcage')
    gpain = Symptom.create!(:name=>'Gastrointestinal pain', :description=>'Stomach and intestinal discomfort')
    dia = Symptom.create!(:name=>'Diarrhea', :description=>'Frequent liquid feces')
    head = Symptom.create!(:name=>'Headache/Migraine', :description=>'Varying head discomfort and pressure')
    bache = Symptom.create!(:name=>'Body aches', :description=>'Pain in muscles and joints')
    rash = Symptom.create!(:name=>'Rash', :description=>'Skin inflamation')
    wease = Symptom.create!(:name=>'Wheezing', :description=>'Wheezing when breathing; asthma')
    allergies = Symptom.create!(:name=>'Allergies', :description=>'Coughing, sneezing, wheezing. Seasonal or specific')
    ot =  Symptom.create!(:name=>'Other', :description=>'Other')
    p1 = Procedure.create!(:name=>'Common illness', :description=>'cold, flu, gastroenteritis, etc', :duration=>20)
    p1.symptoms << fever
    p1.symptoms << apain
    p1.symptoms << gpain
    p1.symptoms << dia
    p1.symptoms << head
    p1.symptoms << bache
    p2 = Procedure.create!(:name=>'Rash/Skin allergy', :description=>'Rash on body', :duration=>20)
    p2.symptoms << rash
    p2.symptoms << allergies
    p3 = Procedure.create!(:name=>'Other', :description=>'Other', :duration=>20)
    p3.symptoms << ot
    p4 = Procedure.create!(:name=>'Pelvic exam', :description=>'Pelvic exam', :duration=>45)
    p5 = Procedure.create!(:name=>'Allergy checkup', :description=>'Test for new or treat existing allergies', :duration=>30)
    p5.symptoms << allergies
    p6 = Procedure.create(:name=>'Asthma checkup', :description=>'Test for or treat existing', :duration=>30)
    p6.symptoms << wease
    Procedure.create!(:name=>'Flu shot', :description=>'Flu shot', :duration=>15)

    c1  =  ClinicProcedure.create!(clinic_id: 1, procedure_id: 1, description: 'A new description and duration', duration: 25)
    5.times do |n|
      procedure = Procedure.find(n+1)
      ClinicProcedure.create!(clinic_id: 1, procedure_id: procedure.id, description: procedure.description, duration: procedure.duration)
    end

    puts 'Creating first appointment'
    a1 = Appointment.create!(clinic_id: 1, doctor_id: 1, patient_id: 1, start_time: Time.zone.now + 2.hours,
                             description: 'I think im dying', duration: c1.duration)
    a1.clinic_procedures << c1

  end
end