class Room < ApplicationRecord
  validates :name, presence: true
  has_many :reservations, dependent: :destroy
end