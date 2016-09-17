class Appointment < ApplicationRecord
  has_and_belongs_to_many :clinic_procedures
  belongs_to :doctor
  belongs_to :patient
  belongs_to :clinic

  validate :no_time_overlap
  validate :clinic_is_open
  validates :doctor_id,  :presence=>true
  validates :patient_id, :presence=>true
  validates :clinic_id,  :presence=>true
  validates :start_time, :presence=>true
  validates :duration,   :presence=>true

  def end_time
    self.start_time + self.duration.minutes
  end

  def no_time_overlap
    end_time = self.start_time + self.duration.minutes
    if self.persisted?
      if Appointment.where("(doctor_id = ? AND start_time >= ? AND start_time <= ?) OR ((start_time + interval '? minutes') >= ? AND (start_time + interval '? minutes')  <= ?) AND id != ?",
                           self.doctor_id, self.start_time, end_time, self.duration, self.start_time, self.duration, end_time, self.id).any?
        errors.add(:start_time, 'Appointment overlaps with another')
      end
    elsif Appointment.where("(doctor_id = ? AND start_time >= ? AND start_time <= ?) OR ((start_time + interval '? minutes') >= ? AND (start_time + interval '? minutes')  <= ?)",
                            self.doctor_id, self.start_time, end_time, self.duration, self.start_time, self.duration, end_time).any?
      errors.add(:start_time, 'Appointment overlaps with another')
    end
  end

  def clinic_is_open
    clinic = Clinic.find(self.clinic_id)
    if clinic.send("is_open_#{self.start_time.strftime("%A").downcase}")
      open_time = DateTime.parse("#{self.start_time.year}/#{self.start_time.month}/#{self.start_time.day} #{clinic.send("#{self.start_time.strftime("%A").downcase}_open_time")}")
      close_time = DateTime.parse("#{self.start_time.year}/#{self.start_time.month}/#{self.start_time.day} #{clinic.send("#{self.start_time.strftime("%A").downcase}_close_time")}")
      if self.start_time < open_time || self.end_time > close_time
        errors.add(:start_time, "Clinic is not open during this time frame")
      end
    else
      errors.add(:start_time, "Clinic is closed on #{self.start_time.strftime("%A")}")
    end
  end

  def as_scheduling_json
    self.as_json({methods: :end_time, only: [:id, :start_time, :duration, :status]})
  end

end
