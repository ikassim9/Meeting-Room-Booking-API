class Reservation < ApplicationRecord
  belongs_to :room
  validates :reserved_by, :start_time, :end_time, presence: true
  validate :validate_time_order
  validate :no_time_conflicts

  # to avoid overlap of reservations
  def no_time_conflicts
    overlapping = room.reservations
    .where("start_time < ? AND end_time > ?", end_time, start_time)
    errors.add(:base, "Room already booked at this time.") if overlapping.exists?
  end
  # avoid start date coming after end time and prevent start end time being equal
  def validate_time_order
    if start_time && end_time && end_time <= start_time
      errors.add(:end_time, "must be after start time.")
  end
end

end
