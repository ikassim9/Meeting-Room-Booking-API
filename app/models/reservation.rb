class Reservation < ApplicationRecord
  belongs_to :room
  validates :reserved_by, :start_time, :end_time, presence: true
end
