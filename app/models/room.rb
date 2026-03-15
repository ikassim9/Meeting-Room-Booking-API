class Room < ApplicationRecord
  validates :name, :capacity, :location, presence: true
end