namespace :db do
  desc 'Fill with sample data'
  task populate: :environment do
    Rake::Task["db:schema:load"].invoke
    puts 'Creating Clinics'
    #moved here as clinic after_save depends on this existing
    p3 = Procedure.create!(:name=>'Other', :description=>'Other', :duration=>20)
    clinic1 = c1 = Clinic.create!(name: 'MGH',
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
                       monday_close_time: '4:00 PM',
                       tuesday_open_time: '8:00 AM',
                       tuesday_close_time: '4:00 PM',
                       wednesday_open_time: '8:00 AM',
                       wednesday_close_time: '4:00 PM',
                       thursday_open_time: '8:00 AM',
                       thursday_close_time: '4:00 PM',
                       friday_open_time: '8:00 AM',
                       friday_close_time: '4:00 PM',
                       default_duration: 20)

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
                         monday_close_time: '4:00 PM',
                         tuesday_open_time: '8:00 AM',
                         tuesday_close_time: '4:00 PM',
                         wednesday_open_time: '8:00 AM',
                         wednesday_close_time: '4:00 PM',
                         thursday_open_time: '8:00 AM',
                         thursday_close_time: '4:00 PM',
                         friday_open_time: '8:00 AM',
                         friday_close_time: '4:00 PM',
                         default_duration: 20)

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
    p3.symptoms << ot
    p4 = Procedure.create!(:name=>'Pelvic exam', :description=>'Pelvic exam', :duration=>45)
    p5 = Procedure.create!(:name=>'Allergy checkup', :description=>'Test for new or treat existing allergies', :duration=>30)
    p5.symptoms << allergies
    p6 = Procedure.create(:name=>'Asthma checkup', :description=>'Test for or treat existing', :duration=>30)
    p6.symptoms << wease
    Procedure.create!(:name=>'Flu shot', :description=>'Flu shot', :duration=>15)

    c1  =  ClinicProcedure.create!(clinic_id: 1, procedure_id: 1, description: 'A new description and duration', duration: 25)
    15.times do |n|
      clinic_id = ((n%4)+1)
      used_procedure_ids = ClinicProcedure.where(:clinic_id=>clinic_id).map(&:procedure_id)
      if used_procedure_ids.empty?
        procedure = Procedure.all.sample
      else
        procedure = Procedure.where("id NOT IN (?)", used_procedure_ids).sample
      end
      ClinicProcedure.create!(clinic_id: clinic_id, procedure_id: procedure.id, description: procedure.description, duration: procedure.duration)
    end

    puts 'Creating first appointment'
    invalid = true
    n = 1
    while invalid
      appointment_time = rand_time_with_intervals(n.day.from_now)
      a = Appointment.new(clinic_id: 1,
                          doctor_id: 1,
                          patient_id: 1,
                          start_time: appointment_time,
                          description: Faker::Lorem.paragraph(4),
                          duration: c1.duration)
      if a.valid?
        a.save!
        a.clinic_procedures << c1
        invalid = false
      else
        n +=1
      end
    end

    # a1 = Appointment.create!(clinic_id: 1, doctor_id: 1, patient_id: 1, start_time: Time.zone.now + 2.hours,
    #                          description: 'I think im dying', duration: c1.duration)

    puts 'Creating sample patients'
    60.times do |n|
      name = Faker::Name.name.split(' ')
      email = "examplePatient#{n+1}@example.com"
      password = 'AndrewMattMDME3000!'
      sex = Patient.sexes.keys.sample.to_sym
      # social_security_number = "#{rand_int(0,9)}#{rand_int(0,9)}#{rand_int(0,9)}-#{rand_int(0,9)}#{rand_int(0,9)}-#{rand_int(0,9)}#{rand_int(0,9)}#{rand_int(0,9)}#{rand_int(0,9)}"
      city = 'Phoenix'
      state = 'AZ'
      zipcode = '85018'
      birthday = Date.today - (rand_int(18,80)).years
      p = Patient.create!(first_name: name[0],
                          last_name: name[1],
                          email: email,
                          password: password,
                          password_confirmation: password,
                          sex: sex,
                          address: "#{Faker::Address.street_address}#{('|' + Faker::Address.secondary_address) if rand(2) == 1}",
                          city: city,
                          state: state,
                          zipcode: zipcode,
                          birthday: birthday)
      p.clinics << clinic1
      if rand(2) == 1
        p.clinics << Clinic.all[1]
      end
      if rand(3) == 1
        p.clinics << Clinic.last
      end
    end

    puts 'Creating sample doctors'
    #sample doctors
    15.times do |n|
      name = Faker::Name.name.split(' ')
      email = "exampleDoctor#{n+1}@example.com"
      password = 'AndrewMattMDME3000!'
      phone_number = rand_int(0,9).to_s + rand_int(0,9).to_s + rand_int(0,9).to_s + '-' + rand_int(0,9).to_s +
          rand_int(0,9).to_s + rand_int(0,9).to_s + '-' + rand_int(0,9).to_s + rand_int(0,9).to_s +
          rand_int(0,9).to_s + rand_int(0,9).to_s
      d = Doctor.create!(first_name: name[0],
                     last_name: name[1],
                     email: email,
                     password: password,
                     password_confirmation: password,
                     phone_number: phone_number)
       d.clinics << Clinic.all[((n%4))]
    end
    Rake::Task["db:populate_appointments"].invoke
  end

  task populate_appointments: :environment do
    puts 'Creating 80 appointments over next 10 days'
    #sample appointments
    100.times do |n|
      patient_id = Patient.all.sample.id
      clinic_procedure = ClinicProcedure.all.sample
      doctor_id = clinic_procedure.clinic.doctors.sample.id

      invalid = true
      while invalid
        appointment_time = rand_time_with_intervals(10.days.from_now)
        a = Appointment.new(clinic_id: clinic_procedure.clinic_id,
                                 doctor_id: doctor_id,
                                 patient_id: patient_id,
                                 start_time: appointment_time,
                                 description: Faker::Lorem.paragraph(4),
                                 duration: clinic_procedure.duration)
        if a.valid?
          a.save!
          a.clinic_procedures << clinic_procedure
          invalid = false
        else
          # puts [Appointment.all.count, a.errors.full_messages.inspect, a.start_time].inspect
        end
      end
    end

    # puts 'Creating 15 appointments today'
    # #sample appointments
    # 30.times do |n|
    #   patient_id = Patient.all.sample.id
    #   clinic_procedure = ClinicProcedure.all.sample
    #   doctor_id = clinic_procedure.clinic.doctors.sample.id
    #   invalid = true
    #   while invalid
    #     appointment_time = rand_time_with_intervals(5.days.from_now)
    #     a = Appointment.new(clinic_id: clinic_procedure.clinic_id,
    #                         doctor_id: doctor_id,
    #                         patient_id: patient_id,
    #                         start_time: appointment_time,
    #                         description: Faker::Lorem.paragraph(4),
    #                         duration: clinic_procedure.duration)
    #     if a.valid?
    #       a.save!
    #       a.clinic_procedures << clinic_procedure
    #       invalid = false
    #     else
    #       puts [Appointment.all.count, a.errors.full_messages.inspect, a.start_time].inspect
    #     end
    #   end
    # end
  end
end


def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(end_time, start_time=Time.now+3.hours)
  Time.at(rand_in_range(start_time.to_f, end_time.to_f))
end

def rand_time_with_intervals(end_date, start_date=Time.zone.now + 40.minutes )
  start_date = start_date.to_datetime
  end_date = end_date.to_datetime
  appt_time = (start_date..end_date).to_a.sample
  hour = (7..18).to_a.sample
  min = (0..55).step(5).to_a.sample
  datetime = Time.zone.parse("#{appt_time.year}-#{appt_time.month}-#{appt_time.day} #{hour}:#{min}")
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

def appt_statuses
  ['requested', 'confirmed', 'checked_in', 'denied', 'canceled', 'delayed', 'completed', 'in_progress']
end
