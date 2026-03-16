class Room < ApplicationRecord
  validates :name, :capacity, :location, presence: true
  has_many :reservations, dependent: :destroy
end